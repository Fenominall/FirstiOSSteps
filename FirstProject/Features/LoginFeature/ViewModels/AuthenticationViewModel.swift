//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation
import Parse

enum UserValidationState {
    case Valid
    case Invalid
    case Empty
    case UsernameAlreadyTaken
    case NoInternetConnection
}

enum UsersAuthenticationStates {
    case login
    case register
    case update
}

class AuthenticationViewModel {
    
    // MARK: - Properties
    private var user = User()
    
    var username: String?
    var password: String?
    // #### Need to fix the issue with the flags ### //
    var usernameIsTaken = false
    var userCredentialsAreCorrect = false
    
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
    
    func validateUser(byUserAuthState userStates: UsersAuthenticationStates) -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Empty
        }
        
        if !AppDataValidator.validateUserName(user.username) ||
            !AppDataValidator.validatePassword(user.password) {
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Invalid
        }
        
        // Start monitoring if the device has internet connection
        NetworkMonitor.shared.startMonitoring()
        // If the device is connected to the internet, provide the selected action
        if NetworkMonitor.shared.isConnected {
            print("DEBUG: The device has internet connection.")
            switch userStates {
            case .login:
                signInUser()
                if userCredentialsAreCorrect {
                    HapticsManager.shared.vibrateForType(for: .success)
                    saveUserToDisk()
                    return .Valid
                } else {
                    HapticsManager.shared.vibrateForType(for: .warning)
                    return .Invalid
                }
            case .register:
                checkIfUserAlreadyCreated(byUsername: user.username)
                if !usernameIsTaken {
                    HapticsManager.shared.vibrateForType(for: .warning)
                    return .UsernameAlreadyTaken
                } else {
                    HapticsManager.shared.vibrateForType(for: .success)
                    // Creating new account on Parse for a user
                    signUpNewUser()
                    saveUserToDisk()
                    return .Valid
                }
            case .update:
                if usernameIsTaken {
                    HapticsManager.shared.vibrateForType(for: .warning)
                    return .UsernameAlreadyTaken
                } else {
                    HapticsManager.shared.vibrateForType(for: .success)
                    // Creating new account on Parse for a user
                    updateCurrentUser()
                    saveUserToDisk()
                    return .Valid
                }
            }
        } else {
            // Stop monitoring if the device has internet connection
            NetworkMonitor.shared.stopMonitoring()
            print("DEBUG: The device does not have internet connection.")
            HapticsManager.shared.vibrateForType(for: .warning)
            return .NoInternetConnection
        }
    }
    
    func checkIfUserAlreadyCreated(byUsername username: String) {
        // Creating new query of users on Parse Server
        let query = PFUser.query()
        // Checking all users by username key to find a match with inputed username by user
        query?.whereKey("username", contains: username)
        // getting each object to check if username is unique or not
        query?.getFirstObjectInBackground { [weak self] (object: PFObject?, error: Error?) -> Void in
            DispatchQueue.main.async {
                if object != nil {
                    self?.usernameIsTaken = true
                    print("DEBUG: The entered username is already taken")
                } else {
                    self?.usernameIsTaken = false
                }
            }
        }
    }
    
    func signUpNewUser() {
        // Creating new instance of a PF user on Parse Server
        let createPFUser = PFUser()
        // updating PFUser with the users input in registration field
        createPFUser.username = user.username
        createPFUser.password = user.password
        // creating new user asynchronously and saving the user data to disk
        createPFUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                // saving user state as logged it if login successful
                UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                print("user logged in")
            } else {
                print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO SIGN UP A USER \(String(describing: error?.localizedDescription)) ")
            }
        }
    }
    
    func signInUser() {
        PFUser.logInWithUsername(inBackground: user.username,
                                 password: user.password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                // saving user state as logged it if login successful
                UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                self.userCredentialsAreCorrect = true
            } else {
                self.userCredentialsAreCorrect = false
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
}
