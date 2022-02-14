//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 01.07.2021.
//

import Foundation
import Parse

class RegistrationViewModel {
    
    // MARK: - Properties
    var onDidiFinishUserValidation: ((_ state: UserValidationState) -> Void)?
    var onDidFailCreateUser: (() -> Void)?
}

// MARK: - Helpers
extension RegistrationViewModel {
    
    // Sign Up New User
    func signUpUserWith(username: String?, password: String?) {
        guard let username = username,
              let password = password else { return }
        
        AppDataValidator.checkIfInputIsEmpty(byUsername: username, password: password) {
            [weak self] in
            self?.onDidiFinishUserValidation?(.empty)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        if !AppDataValidator.validateUserName(username) ||
            !AppDataValidator.validatePassword(password) {
            onDidiFinishUserValidation?(.invalid)
        } else {
            // Start monitoring if the device has internet connection
            if NetworkMonitor.shared.isConnected {
                print("DEBUG: The device has internet connection.")
                UserService.shared.signUpUser(with: username, password: password) { [weak self] value in
                    switch value {
                    case true:
                        do {
                            try UserCaretaker.createUser(withUsername: username, password: password)
                        } catch let (error) {
                            print("DEBUG: An error occurred when creating new user and saving to disk \(error) ")
                        }
                        // saving user state as logged it if login successful
                        UserDefaults.standard.setValue(true, forKey: UserKey.isLoggedIn)
                        HapticsManager.shared.vibrateForType(for: .success)
                        self?.onDidiFinishUserValidation?(.valid)
                    case false:
                        HapticsManager.shared.vibrateForType(for: .error)
                        self?.onDidiFinishUserValidation?(.usernameAlreadyTaken)
                    }
                }
            } else {
                // Stop monitoring if the device has internet connection
                print("DEBUG: The device does not have internet connection.")
                HapticsManager.shared.vibrateForType(for: .error)
                self.onDidiFinishUserValidation?(.noInternetConnection)
                NetworkMonitor.shared.stopMonitoring()
            }
        }
    }
}
