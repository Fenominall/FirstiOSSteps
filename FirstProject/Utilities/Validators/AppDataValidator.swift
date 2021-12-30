//
//  AppDataValidator.swift
//  DGTX
//
//  Created by Alexey Zayakin on 29.04.2021.
//


// MARK: - Explanation about Regex
/// Quantifier    Legend    Example    Sample Match
/// +     One or more    Version \w-\w+    Version A-b1_1
/// {3}       Exactly three times    \D{3}    ABC
/// {2,4}    Two to four times    \d{2,4}    156
/// {3,}    Three or more times    \w{3,}    regex_tutorial
/// *    Zero or more times    A*B*C*    AAACC
/// ?    Once or none    plurals?    plural
/// .    Any character except line break    a.c    abc
/// .    Any character except line break    .*    whatever, man.
/// \.    A period (special character: needs to be escaped by a \)    a\.c    a.c
/// \    Escapes a special character    \.\*\+\?    \$\^\/\\    .*+?    $^/\
/// \    Escapes a special character    \[\{\(\)\}\]    [{()}]
/// (^) - at the beginning means we want to match at the beginning
/// ($) - means match at the end
/// ?= - is positive lookahead i.e. it matches the expression by looking ahead and sees if there is any pattern that matches your search parameter like [A-Z]
///  .* - allows for literally any combination of characters to be entered


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
        // At least 8 characters up to 20
        #"(?=.{8,20})"# +
        
        // At least one capital letter
        //            #"(?=.*[A-Z])"# +
        
        // At least one lowercase letter
        //            #"(?=.*[a-z])"# +
        
        //          All number are available
        #"(?=.*[0-9])"# +
        
        // At least one digit
        //            #"(?=.*\d)"# +
        
        // At least one special character
        #"(?=.*[ !@$%&?._-])"#
        
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
        #"(?=.{4,20})"# +
        
        // All characters available
        #"^[a-zA-Z-]"#
        
        let result = userName.range(
            of: userNamePattern,
            options: .regularExpression
        )
        
        return (result != nil)
    }
}
