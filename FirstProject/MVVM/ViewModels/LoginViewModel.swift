//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation

enum UserValidationState {
    case Valid
    case Invalid
    case Empty
}

class LoginViewModel {
    
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
        } else if !AppDataValidator.validateUserName(user.username) ||
                    !AppDataValidator.validatePassword(user.password) {
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Invalid
        }
        // Phone Vibrations
        HapticsManager.shared.vibrateForType(for: .success)
        saveUser()
        return .Valid
    }
    
    func saveUser() {
        // saving user state as logged it if login successful
        UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
        // Saving user data to disk with File-manager
        do {
            try UserCaretaker.createUser(user: user)
        } catch {
            print("Got error when saving a newUser: \(error)")
        }
    }
}
