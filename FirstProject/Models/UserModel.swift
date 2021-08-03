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
}









//struct User: Codable {
//
//    var username: String
//    var password: String
//
//    init(vm: LoginViewModel) {
//        self.username = vm.username
//        self.password = vm.password
//    }
//}


// MARK: Protocol to compare objects
//extension User: Equatable {
//    static func == (lhs: User, rhs: User) -> Bool {
//        return lhs.username == rhs.username && lhs.password == rhs.password
//    }
//}
