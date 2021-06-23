//
//  AppDataValidator.swift
//  DGTX
//
//  Created by Alexey Zayakin on 29.04.2021.
//

import Foundation

struct AppDataValidator {
    
    ///Email validation
    static func validateEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
    
    ///Password validation
    /// * At least 8 characters
    /// * At least one capital letter
    /// * At least one lowercase letter
    /// * At least one digit
    /// * At least one special character
    /// # Example: $tr0ngPa$$w0rd
    static func validatePassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
            
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,})"# +

            // At least one capital letter
            #"(?=.*[A-Z])"# +
                
            // At least one lowercase letter
            #"(?=.*[a-z])"# +
                
            // At least one digit
            #"(?=.*\d)"# +
                
            // At least one special character
            #"(?=.*[ !$%&?._-])"#
        
        let result = password.range(
            of: passwordPattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
    
    ///Password validation
    /// * At least 4 characters
    static func validateUserName(_ userName: String?) -> Bool {
        guard let userName = userName else { return false }
        
        let userNamePattern =
            // At least 4 characters
            #"(?=.{4,})"# +
        
            // All characters avaible
            #"^[a-zA-Z-]"#
        
        let result = userName.range(
            of: userNamePattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
    
}


