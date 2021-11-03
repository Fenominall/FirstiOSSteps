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

extension LoginViewModel {

    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
    
    func validateUser() -> UserValidationState {
        
        if user.username.isEmpty || user.password.isEmpty {
            return .Empty
        } else if !AppDataValidator.validateUserName(username.value) || !AppDataValidator.validatePassword(password.value) {
            return .Invalid
        }
        return .Valid
    }
}


