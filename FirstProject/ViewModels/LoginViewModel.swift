//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation


struct LoginViewModel {
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
