//
CustomUserDefaults.swift
//  FirstProject
//
//  Created by Fenominall on 03.07.2021.
//

import Foundation

class CustomUserDefaults {
  // defined needed keys
  enum DefaultsKey: String, CaseIterable {
    case username
    case password
  }
  
  static let shared = CustomUserDefaults()
  private let defaults = UserDefaults.standard
  
  init() {}
  
  // to set value using pre-defined key
    func set(_ value: Any?, key: DefaultsKey) {
        defaults.setValue(value, forKey: key.rawValue)
    }
    // get value using pre-defined key
    func get(key: DefaultsKey) -> Any? {
        return defaults.value(forKey: key.rawValue)
    }
}


