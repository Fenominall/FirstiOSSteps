//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation

// MARK: UserModel

struct User: Codable {
    internal init(username: String = "", password: String = "") {
        self.username = username
        self.password = password
    }
    

    var username: String = ""
    var password: String = ""
   
    
}


