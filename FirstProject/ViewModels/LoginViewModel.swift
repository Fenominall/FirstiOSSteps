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
    private var user = User()

    var username: String {
        return user.username
    }

    var password: String {
        return user.password
    }
}

extension LoginViewModel {

    func updateUsername(username: String) {
        user.username = username
    }

    func updatePassword(password: String) {
        user.password = password
    }

    func validate() -> UserValidationState {
        
        if user.username.isEmpty || user.password.isEmpty {
            return .Empty

        } else if !AppDataValidator.validateUserName(username) && !AppDataValidator.validatePassword(password){
            return .Invalid
        }

        return .Valid
    }
    
    func login() {
        print("You are logged in with \(user.username) username and \(user.password) password.")
    }

}

