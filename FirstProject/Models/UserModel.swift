//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation
//
//class Base {
//    let defaults = UserDefaults.standard
//
//    struct User: Codable {
//        var username: String
//        var password: String
//        var name: String {
//            return "\(username)"
//        }
//    }
//
//    static let storageKey: String = "Users"
//
//    var userData: [User]{
//        get {
//            if let data = defaults.value(forKey: Base.storageKey) as? Data {
//                return try! PropertyListDecoder().decode([User].self, from: data)
//            }
//        } else {
//            return [User]
//        }
//        set {
//            if let data = try? PropertyListEncoder().encode(newValue) {
//                defaults.set(data, forKey: Base.storageKey)
//            }
//        }
//    }
//
//    func saveUser(username: String, password: String) {
//        let user = User(username: username, password: password)
//        userData.insert(user, at: 0)
//    }
//
//}

// MARK: UserModel
struct User: Codable {
    var username: String
    var password: String
    
    init(vm: LoginViewModel) {
        self.username = vm.username
        self.password = vm.password
    }
}
		
// MARK: Protocol to compare objects
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}

//extension User {
//    static let storageKey: String = "Users"
//
//    func save() {
//        let users: [User] = [self]
//        UserDefaults.standard.setValue(users, forKey: User.storageKey)
//    }
//}

