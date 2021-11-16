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

protocol UpdateUserData {
    func updateUsername(username: String)
    func updatePassword(password: String)
    func validateUser() -> UserValidationState
}

protocol ShareData {
    
}

class LoginViewModel {
    
    private var user = User() {
        didSet {
            username.value = user.username
            password.value = user.password
        }
    }
    
    var username: Box<String> = Box("")
    var password: Box<String> = Box("")
    
    // MARK: - Object Lifecycle
    init(user: User = User()) {
        self.user = user
    }
}

extension LoginViewModel: UpdateUserData {
    
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
        } else if !AppDataValidator.validateUserName(user.username) || !AppDataValidator.validatePassword(user.password) {
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
        UserDefaults.standard.setCodable(user, forKey: UserKey.storageKey)
    }
}
