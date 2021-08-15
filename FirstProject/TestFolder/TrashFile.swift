//
//  File.swift
//  FirstProject
//
//  Created by Fenominall on 11.08.2021.
//


//        guard let username = usernameTxtField.text,
//              let password = passwordTxtField.text else { return }
//
//        let userNameTrimmingText = username.trimmingCharacters(in: .whitespaces)
//        let passwordTrimmingText = password.trimmingCharacters(in: .whitespaces)
//
//        let isUsernameValid = AppDataValidator.validateUserName(userNameTrimmingText)
//        let isPasswordValid = AppDataValidator.validatePassword(passwordTrimmingText)
//
//
//        if username.isEmpty && password.isEmpty {
//            AppAlerts.emptyFieldsErrorAlert(on: self)
//        }
//
//        if username.isEmpty {
//            AppAlerts.emptyUsernameErrorAlert(on: self)
//        }
//
//        if password.isEmpty {
//            AppAlerts.emptyPasswordErrorAlert(on: self)
//        }
//
//        if isUsernameValid && isPasswordValid {
//            // Navigation controller
//            let secondVC = SecondViewController()
//            self.navigationController?.pushViewController(secondVC, animated: true)
//
//            // # Phone Vibration
//            HapticsManager.shared.vibrateForType(for: .success)
//
//            // # Success Alert
//            AppAlerts.showIncompleteSuccessUIAlert(on: self)
//
//        } else {
//
//            // # Phone Vibration
//            HapticsManager.shared.vibrateForType(for: .error)
//
//            // # Button shake
//            sender.shake()
//
//            // # Error Alert
//            AppAlerts.showIncompleteErrorUIAlert(on: self)
//        }


// Can be used with 
