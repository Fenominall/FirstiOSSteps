//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation

enum UserValidationState {
    case Valid
    case Invalid(String)
}


class LoginViewModel {
    
    private var user = User()
    
    var username: String {
        return user.username
    }
    
    var password: String {
        return user.password
    }
   
}

extension LoginViewModel {
        
    func updateUsername(username: String) {
        user.username = username
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
    
    func validate() -> UserValidationState {
        let userNameTriimingText = username.trimmingCharacters(in: .whitespaces)
        let passwordTrimmingText = password.trimmingCharacters(in: .whitespaces)
        
        if user.username.isEmpty || user.password.isEmpty {
            return .Invalid("Username and password are required ")
            
        } else if !AppDataValidator.validateUserName(userNameTriimingText) && !AppDataValidator.validatePassword(passwordTrimmingText){
            return .Invalid("""
                          Username should be at least (min-4, max-20) charachters long.
                          Password can be only digits and at least 1 special charechter, should contain (min-8, max-20) charachters long.
                """)
        }
        
        return .Valid
    }
    
}



//class LoginViewModel {
//    // MARK: Stored Properties
////    private let loginManager: LoginManager
//
//    // Model notifies taht is was updated
//    private var user = User() {
//        didSet {
//            username = user.username
//            password = user.password
//        }
//    }
//
//    private var username = ""
//    private var password = ""
//
//    var credentialsInputErrorMessage: Observable<String> = Observable("")
//    var isUsernameTextFieldHighlighted: Observable<Bool> = Observable(false)
//    var isPasswordTextFieldHighlighted: Observable<Bool> = Observable(false)
//    var errorMessage: Observable<String?> = Observable(nil )
//
//    init(loginManager: LoginManager) {
//        self.loginManager = LoginManager
//    }
//
//    // Model Update
//    func updateCredentials(username: String, password: String, otp: String? = nil) {
//        user.username = username
//        user.password = password
//    }
//
//    func login() {
//        loginManager.loginWithCredentials(username: username, password: password) { [weak self]
//            guard let error = error else { return }
//            self.errorMessage.value = error.localizedDescription
//        }
//    }
//
//    func credentialsInput() -> CredentialsInputStatus {
//        if username.isEmpty && password.isEmpty {
//            AppAlerts.emptyFieldsErrorAlert(on: self)
//        }
//    }
//
//}
//
//extension LoginViewModel {
//
//    enum CredentialsInputStatus {
//        case Correct
//        case Incorrect
//    }
//}
