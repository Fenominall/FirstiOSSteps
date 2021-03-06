//
//  FirstProject
//
//  Created by Fenominall on 03.07.2021.
//
import Foundation
import UIKit

class CustomUserDefaults {
    // defined needed keys
    enum UserKeys: String, CaseIterable {
        case username
        case password
        case isUserLogin
    }
    
    static let shared = CustomUserDefaults()
    private let defaults = UserDefaults.standard
    
    init() {}
    
    
    
    // to set value using pre-defined key
    func set(_ value: Any?, key: UserKeys) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    // get value using pre-defined key
    func get(key: UserKeys) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
    
    // check value if exist or nil
    func hasValue(key: UserKeys) -> Bool {
        return defaults.value(forKey: key.rawValue) != nil
    }
    
    // remove all stored values
    func removeAll() {
        for key in UserKeys.allCases {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
}

// if let savedName = CustomUserDefaults.shared.get(key: .name) as? String {
//     print(savedName) // result: john@example.com
// }

extension UserDefaults {
    
    private enum Keys {
        static let myKey = "myKey"
        static let isUserLogin = "isLoggedIn"
    }
    
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(value) else {
            fatalError("Cannot create a json representation of \(value)")
        }
        self.set(data, forKey: key)
    }
    
    func loadCodable<T: Codable>(forKey key: String, castTo type: T.Type) -> T? {
        guard let data = self.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    // Check if a key-value pair exists in the user's defaults database.
    func valueExists(forKey key: String) -> Bool {
        return object(forKey: key) != nil
    }
}


extension UserDefaults {
    
    private enum UserKeys {
        static let isLoggedIn = "isLoggedIn"
    }
}
