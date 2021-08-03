//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation

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



//class LoginViewModel {
//
//    var username: String
//    var password: String
//
//    init(username: String, password: String) {
//        self.username = username
//        self.password = password
//    }
//}
//
//
//extension LoginViewModel {
//
//    static let strogaeKey: String = "Users"
//
//    func saveUserData() {
//
//        let user = User(vm: self)
//
//        defaults.setCodable(user, forKey: LoginViewModel.strogaeKey)
//    }
////
////    func loadUser() {
////
////        defaults.string(forKey: LoginViewModel.strogaeKey)
////    }
//
//
//}
