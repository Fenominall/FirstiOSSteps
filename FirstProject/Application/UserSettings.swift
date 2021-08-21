//
//  UserDefaults+.swift
//  FirstProject
//
//  Created by Fenominall on 03.07.2021.
//


//final class UserSettings {
//
//    private enum SettingsKeys: String {
//        case userName
//        case userModel
//    }
//
//
//    static var userModel: User! {
//        get {
//            guard let savedData = UserDefaults.standard.object(forKey: SettingsKeys.userModel.rawValue) as? Data, let decodedModel = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? User else { return nil }
//            return decodedModel
//        }
//        set {
//            let defaults = UserDefaults.standard
//            let key = SettingsKeys.userModel.rawValue
//
//            if let userModel = newValue {
//                if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: userModel, requiringSecureCoding: false) {
//                    print("value: \(userModel) was added to key \(key)")
//                    defaults.set(savedData, forKey: key)
//                } else {
//                    defaults.removeObject(forKey: key)
//                }
//            }
//        }
//    }
//
//    static var userName: String! {
//        get {
//            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
//        } set {
//
//            let defaults = UserDefaults.standard
//            let key = SettingsKeys.userName.rawValue
//            if let name = newValue {
//                print("value: \(name) was added to key \(key)")
//                defaults.set(name, forKey: key)
//            } else {
//                defaults.removeObject(forKey: key)
//            }
//        }
//    }
//}
