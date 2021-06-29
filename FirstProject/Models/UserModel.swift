//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation

struct User: Codable {
    var username: String
    var password: String
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}

extension User {
    static let storageKey: String = "Users"
    
    func save() {
        let users: [User] = [self]
        UserDefaults.standard.setValue(users, forKey: User.storageKey)
    }
}
