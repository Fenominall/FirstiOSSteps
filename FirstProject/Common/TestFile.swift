//
//  TestFile.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

import Foundation





// MARK: Created keys for Username and Password for UserDefaults
//struct UserKeysDefaults {
//    static let keyUsername = "username"
//    static let keyPassword = "password"
//}



// MARK: Function for UserDefaults for saving data
//        saveUsernameAndPassword()



//   MARK: Save password in UITextField placeholders
//    private func saveUsernameAndPassword() {
//
//        if let enteredUsername = defaults.string(forKey: UserKeysDefaults.keyUsername) {
//            usernameTxtField.text = enteredUsername
//        }
//        if let enteredPassword = defaults.string(forKey: UserKeysDefaults.keyPassword) {
//            passwordTxtField.text = enteredPassword
//        }
//    }



//         Check for UITextFields if it`s not empty then save it to UserDefaults
//        if ((username.count != 0) && (password.count != 0)) {
    
//            defaults.setValue(username, forKey: UserKeysDefaults.keyUsername)
//            defaults.setValue(passwordTxtField.text!, forKey: UserKeysDefaults.keyPassword)


//        }

//
//
//
//// MARK: Defining number of lines for notificationLabel
//notificationLabel.numberOfLines = 0
//
//// #
//usernameTxtField.delegate = self
//passwordTxtField.delegate = self
//
////  MARK: UITextField validation
//private let minimumPasswordLength = 8
//private let maximumPasswordLength = 20
//private lazy var regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#-;:`<>|{}[]%])[a-Az-z~,.\\d$@$!%*?&#-;:`<>|{}[]%]]{\(minimumPasswordLength),}$"
//private let password = "VladTest123!"
//
////     UITextField Validator
//private func checkValdiation(usernameTxtField: String) {
//    guard usernameTxtField.count >= minimumPasswordLength else {
//        notificationLabel.text = ""
//        return
//    }
//    guard usernameTxtField.count <= maximumPasswordLength else {
//        notificationLabel.text = ""
//        return
//    }
//    if usernameTxtField.matches(regex) {
//        notificationLabel.textColor = .green
//        notificationLabel.text = "The password is valid"
//    } else {
//        notificationLabel.textColor = .white
//        notificationLabel.text = "MIn \(minimumPasswordLength) symbols\nMax \(maximumPasswordLength) symbols \nShould contain: \n1 capital letter, \n1 lower case letter, \n1 number, \n1 special symbol"
//    }
//}
//
//
//extension LoginScreenViewController: UITextFieldDelegate {
//
////    Function that limits the number of characters in a UITextField
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if  (string == " ") {
//            return false
//        }
//        let text = (textField.text ?? "") + string
//        let result: String
//
//        if range.length == 1 {
//            let end = text.index(text.startIndex, offsetBy: text.count - 1)
//            result = String(text[text.startIndex..<end])
//        } else {
//            result = text
//        }
//
//        checkValdiation(usernameTxtField: result)
//        textField.text = result
//        return false
//    }
//
////    MARK: - Keyboard will hide if the user confirms that editing changed;
////    MARK: 2 - The notification will be shown based on checkValidation func;
//    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == usernameTxtField || textField == passwordTxtField {
//            self.usernameTxtField.resignFirstResponder()
//            self.passwordTxtField.resignFirstResponder()
//            let isSucess = (textField.text == password)
//            notificationLabel.text = isSucess ? "Success" : "Error"
//            notificationLabel.textColor = isSucess ? .green : .red
//        }
//        return true
//    }
//}
//
//extension String {
//    func matches(_ regex: String) -> Bool {
//        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
//    }
//}
