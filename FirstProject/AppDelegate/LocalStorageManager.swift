//
//  LocalStorageManager.swift
//  FirstProject
//
//  Created by Fenominall on 08.08.2021.
//
//
//import Foundation
//
//class LocalStorageManager {
//
//    public func saveUser(user: User) {
//        do {
//             
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(user)
//            let json = String(data: jsonData, encoding: .utf8) ?? "{}"
//
//            let defaults: UserDefaults = UserDefaults.standard
//            defaults.set(json, forKey: "user")
//            defaults.synchronize()
//
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    public func getUser() -> User {
//        do {
//            if (UserDefaults.standard.object(forKey: "user") == nil) {
//                return User()
//            } else {
//                let json = UserDefaults.standard.string(forKey: "user") ?? "{}"
//
//                let jsonDecoder = JSONDecoder()
//                guard let jsonData = json.data(using: .utf8) else {
//                    return User()
//                }
//
//                let user: User = try jsonDecoder.decode(User.self, from: jsonData)
//                return user
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        return User()
//    }
//
//    public func removeUser() {
//        let defaults: UserDefaults = UserDefaults.standard
//        defaults.removeObject(forKey: "user")
//        defaults.synchronize()
//    }
//}
