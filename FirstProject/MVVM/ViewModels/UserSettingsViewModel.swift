//
//  UsernamePasswordViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//



class UserSettingsViewModel {
    
    private var updatedUser = User()
    
    
    init(updatedUser: User = User()) {
        self.updatedUser = updatedUser
    }
    
    
    var username: Box<String> = Box("")
    var password: Box<String> = Box("")
    
    init(username: String, password: String) {
        self.username = Box<String>(username)
        self.password = Box<String>(password)
    }
}

extension UserSettingsViewModel: UpdateUserData {
    
    func updateUsername(username: String) {
        updatedUser.username = username
    }
    
    func updatePassword(password: String) {
        updatedUser.password = password
    }
    
    func validateUser() -> UserValidationState {
        if updatedUser.username.isEmpty || updatedUser.password.isEmpty {
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Empty
        } else if !AppDataValidator.validateUserName(updatedUser.username) || !AppDataValidator.validatePassword(updatedUser.password) {
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            return .Invalid
        }
        // Phone Vibrations
        HapticsManager.shared.vibrateForType(for: .success)
        return .Valid
    }
}

