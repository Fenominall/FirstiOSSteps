//
//  UserModel.swift
//  FirstProject
//
//  Created by Fenominall on 29.06.2021.
//

import Foundation

// MARK: UserModel

struct User {
    
    var username: String = ""
    var password: String = ""
}





//class User: NSObject, NSCoding {

//    var username: String
//    var password: String
    
//    func encode(with coder: NSCoder) {
//        coder.encode(username, forKey: "name")
//        coder.encode(password, forKey: "password")
//    }
//
//    required init?(coder: NSCoder) {
//        username = coder.decodeObject(forKey: "name") as? String ?? ""
//        password = coder.decodeObject(forKey: "password") as? String ?? ""
//    }
    
//    init(username: String, password: String) {
//        self.username = username
//        self.password = password
//    }
//
//}


