//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//
import Foundation
import UIKit


class LoginScreenViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    private var loginViewModel = LoginViewModel()
    
    var shareLoginScreenView = LoginScreenView()
    
    override func loadView() {
        view = shareLoginScreenView
    }
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Notifications for swhowing and hiding keyboard
        observeKeyboardNofitications()
        
        shareLoginScreenView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        setDelegatesOfUITextFields()
    }
    
    /// Function for loginButton: Check validation, pushes the user to the SecondViewController if requirments suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(_ sender: UIButton) {
        
        switch loginViewModel.validateUser() {
        case .Valid:
            loginViewModel.login()
//             // SecondVC Navigation Controller
            coordinator?.eventOccurred(with: )
//             let secondVC = HomeScreenViewController()
//             self.navigationController?.pushViewController(secondVC, animated: true)
            // Phone Vibrations
            HapticsManager.shared.vibrateForType(for: .success)
            // Success Alert
            AppAlerts.showIncompleteSuccessUIAlert(on: self)
           
        case .Empty:
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .error)
            // Button Shake
            sender.shake()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .Invalid:
            // Phone Vibration
            HapticsManager.shared.vibrateForType(for: .warning)
            // Button Shake
            sender.shake()
            // Inproper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        }
    }
}


extension LoginScreenViewController {
    
    func setDelegatesOfUITextFields() {
        shareLoginScreenView.usernameTxtField.delegate = self
        shareLoginScreenView.passwordTxtField.delegate = self
    }
    
//    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == shareLoginScreenView.usernameTxtField {
            loginViewModel.updateUsername(username: newString.trimmingCharacters(in: .whitespaces))
        } else if textField == shareLoginScreenView.passwordTxtField {
            loginViewModel.updatePassword(password: newString.trimmingCharacters(in: .whitespaces))
        }

        if (string == " " || string == "    ") {
            return false
        }
        return true
    }

}
