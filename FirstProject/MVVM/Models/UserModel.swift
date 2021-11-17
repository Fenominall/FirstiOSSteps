//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation

// MARK: UserModel

public struct User: Codable {
    
    var username: String = ""
    var password: String = ""
    
    //    internal init(username: String = "", password: String = "") {
    //        self.username = username
    //        self.password = password
    //    }
}


extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
        && lhs.password == rhs.password
    }
}
