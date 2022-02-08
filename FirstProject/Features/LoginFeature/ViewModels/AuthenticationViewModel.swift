//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation
import Parse

class AuthenticationViewModel {
    
    // MARK: - Properties
    private var user = User()
    
    var username: String?
    var password: String?

    var onDidiFinishUserValidation: ((_ state: UserValidationState) -> Void)?
    var onDidFailCreateUser: (() -> Void)?
    
    // MARK: - Object Lifecycle
    init(user: User = User()) {
        self.user = user
        // loading created user
        do {
            let user = try UserCaretaker.loadUserData()
            self.username = user.username
            self.password = user.password
        } catch {
            print("Got error when loading a user: \(error)")
        }
    }
}

// MARK: - Helpers
extension AuthenticationViewModel {
    
    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }

    func checkIfUserAlreadyCreated(byUsername username: String, completion: @escaping ((_ value: Bool) -> Void)) {
        // Creating new query of users on Parse Server
        let query = PFQuery(className: "User")
        // Checking all users by username key to find a match with inputed username by user
        query.whereKey("username", contains: username)
        // getting each object to check if username is unique or not
        query.getFirstObjectInBackground { (object: PFObject?, error: Error?) -> Void in
            if object != nil {
                completion(true)
                print("DEBUG: The entered username is already taken")
            } else {
                completion(false)
            }
        }
    }
    
    func signUpUserProcess(with username: String, password: String) {
        // Creating new instance of a PF user on Parse Server
        let createPFUser = PFUser()
        // updating PFUser with the users input in registration field
        createPFUser.username = username
        createPFUser.password = password
        // creating new user asynchronously and saving the user data to disk
        createPFUser.signUpInBackground { [weak self] (success: Bool, error: Error?) in
            if success {
                // saving user state as logged it if login successful
                UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                self?.onDidiFinishUserValidation?(.valid)
            } else {
                self?.onDidiFinishUserValidation?(.usernameAlreadyTaken)
                print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO SIGN UP A USER \(String(describing: error?.localizedDescription)) ")
            }
        }
    }
    
    func signInUser(completion: @escaping (_ value: Bool) -> Bool) {
        PFUser.logInWithUsername(inBackground: user.username,
                                 password: user.password) { [weak self]
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                // saving user state as logged it if login successful
                UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                self?.onDidiFinishUserValidation?(.valid)
            } else {
                self?.onDidiFinishUserValidation?(.invalid)
                print("DEBUG: AN ERROR OCCURRED WWHEN TRYING TO LOG IN THE USER \(error?.localizedDescription ?? "") ")
            }
        }
    }
    
    func updateCurrentUser() {
        // Getting the current logged in user on Parse Server
        let currentPFUser = PFUser.current()
        // Updating currentPFUser with the inputed data that updated the User model in the app
        currentPFUser?.username = user.username
        currentPFUser?.password = user.password
        // saving changes of currentPFUser to Parse Server
        currentPFUser?.saveInBackground()
    }
    
    fileprivate func saveUserToDisk() {
        do {
            try UserCaretaker.createUser(user: user)
        } catch {
            print("DEBUG: Got error when saving a newUser: \(error)")
        }
    }
    
    // Sign Up New User
    func signUpUser() {
        let username = user.username
        let password = user.password

        AppDataValidator.checkIfInputIsEmpty(byUsername: username, password: password) {
            [weak self] in
            self?.onDidiFinishUserValidation?(.empty)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        AppDataValidator.validateUserInputCredentials(byUsername: username, password: password) { [weak self] in
            self?.onDidiFinishUserValidation?(.invalid)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        // Start monitoring if the device has internet connection
        if NetworkMonitor.shared.isConnected {
            print("DEBUG: The device has internet connection.")
            checkIfUserAlreadyCreated(byUsername: username) { [weak self] value in
                switch value {
                case true:
                    self?.onDidiFinishUserValidation?(.usernameAlreadyTaken)
                case false:
                    self?.signUpUserProcess(with: username, password: password)
                }
            }
        } else {
            // Stop monitoring if the device has internet connection
            print("DEBUG: The device does not have internet connection.")
            HapticsManager.shared.vibrateForType(for: .warning)
            self.onDidiFinishUserValidation?(.noInternetConnection)
            NetworkMonitor.shared.stopMonitoring()
            return
        }
    }
}
