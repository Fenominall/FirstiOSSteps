//
//  UsernamePasswordViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

class UserViewModel {
    var username: Box<String>!
    var password: Box<String>!
    
    init(username: String, password: String) {
        self.username = Box<String>(username)
        self.password = Box<String>(password)
    }
    
}
