//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation
import Parse

class RegistrationViewModel {
    
    // MARK: - Properties
    var username: String?
    var password: String?

    var onDidiFinishUserValidation: ((_ state: UserValidationState) -> Void)?
    var onDidFailCreateUser: (() -> Void)?
    
    // MARK: - Object Lifecycle
    init() {
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
extension RegistrationViewModel {
    
    private func signUpUserProcess(with username: String, password: String, completion: @escaping(_ value: Bool) -> Void) {
        // Creating new instance of a PF user on Parse Server
        let createPFUser = PFUser()
        // updating PFUser with the users input in registration field
        createPFUser.username = username
        createPFUser.password = password
        // creating new user asynchronously and saving the user data to disk
        createPFUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                completion(true)
            } else {
                completion(false)
                print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO SIGN UP A USER \(String(describing: error?.localizedDescription)) ")
            }
        }
    }
    
    func signInUserWith(username: String, password: String, completion: @escaping (_ value: Bool) -> Bool) {
        PFUser.logInWithUsername(inBackground: username,
                                 password: password) { [weak self]
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
    
    func updateCurrentUser(username: String, password: String) {
        // Getting the current logged in user on Parse Server
        let currentPFUser = PFUser.current()
        // Updating currentPFUser with the inputed data that updated the User model in the app
        currentPFUser?.username = username
        currentPFUser?.password = password
        // saving changes of currentPFUser to Parse Server
        currentPFUser?.saveInBackground()
    }
    
    // Sign Up New User
    func signUpUserWith(username: String?, password: String?) {
        guard let username = username,
              let password = password else { return }

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
            signUpUserProcess(with: username, password: password) { [weak self] value in
                switch value {
                case true:
                    do {
                        try UserCaretaker.createUser(withUsername: username, password: password)
                    } catch let (error) {
                        print("DEBUG: An error occurred when creating new user and saving to disk \(error) ")
                    }
                    // saving user state as logged it if login successful
                    UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                    self?.onDidiFinishUserValidation?(.valid)
                case false:
                    self?.onDidiFinishUserValidation?(.usernameAlreadyTaken)
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
