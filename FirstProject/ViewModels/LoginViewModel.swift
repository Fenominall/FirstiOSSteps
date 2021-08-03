//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation

class LoginViewModel {
    
    var username: String
    var password: String
        
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}


extension LoginViewModel {
    
    static let strogaeKey: String = "Users"
    
    func saveUserData() {
        
        let user = User(vm: self)
        
        defaults.setCodable(user, forKey: LoginViewModel.strogaeKey)
    }
//
//    func loadUser() {
//
//        defaults.string(forKey: LoginViewModel.strogaeKey)
//    }
    
    
}
