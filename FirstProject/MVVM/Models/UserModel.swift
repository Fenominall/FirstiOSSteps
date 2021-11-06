//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation

// MARK: UserModel

struct User: Codable {
    
    var username: String = ""
    var password: String = ""
    
    //    internal init(username: String = "", password: String = "") {
    //        self.username = username
    //        self.password = password
    //    }
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
        && lhs.password == rhs.password
    }
}


extension User {
    
    static let storageKey: String = "Users"
    
    func save() {
        let users: [User] = [self]
        UserDefaults.standard.setValue(users, forKey: User.storageKey)
    }
    
    func load() {
        UserDefaults.standard.object(forKey: User.storageKey)
    }
    
}
