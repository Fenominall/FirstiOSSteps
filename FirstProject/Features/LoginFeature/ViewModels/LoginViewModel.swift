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
}

class LoginViewModel: Coordinating {
    
    var coordinator: Coordinator?
    
    // MARK: - Properties
    private var user = User()
    
    var username: String?
    var password: String?
    
    
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
extension LoginViewModel {
    
    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
    
    func validateUser() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Empty
        }
        if !AppDataValidator.validateUserName(user.username) ||
                    !AppDataValidator.validatePassword(user.password) {
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Invalid
        }
        // Phone Vibrations
        HapticsManager.shared.vibrateForType(for: .success)
        signUpUser()
        // Saving user data to disk with File-manager
        saveUserToDisk()
        return .Valid
    }

    func signUpUser() {
        let createPFUser = PFUser()
        createPFUser.username = user.username
        createPFUser.password = user.password
        
        createPFUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                // saving user state as logged it if login successful
                UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
            } else {
                print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO SIGN UP A USER \(String(describing: error?.localizedDescription)) ")
            }
        }
    }
    
    fileprivate func saveUserToDisk() {
        do {
            try UserCaretaker.createUser(user: user)
        } catch {
            print("DEBUG: Got error when saving a newUser: \(error)")
        }
    }
    
}