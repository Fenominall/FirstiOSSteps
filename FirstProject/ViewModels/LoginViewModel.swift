//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation

// MARK: Shortcut key to use UserDefaults
let defaults = UserDefaults.standard

class LoginViewModel {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

extension LoginViewModel {
    static let storageKey: String = "Users"

    func save() {
        let user = User(vm: self)
        
        do {
            try defaults.setObject(user, forKey: LoginViewModel.storageKey)
        } catch {
            print(error)
        }
    }

    func load() {

        defaults.string(forKey: LoginViewModel.storageKey)
    }
}
