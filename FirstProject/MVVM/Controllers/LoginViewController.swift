//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//
import Foundation
import UIKit


class LoginViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var loginViewModel = LoginViewModel()
    var loginView = LoginView()
    
    
    
    //MARK: - lifecycle
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Notifications for showing and hiding keyboard
        observeKeyboardNotifications()
        configureData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loginView.usernameTxtField.addBottomBorder()
        loginView.passwordTxtField.addBottomBorder()
    }
    
    // MARK: - Selectors
    /// Function for loginButton: Check validation, pushes the user to the SecondViewController if requirements suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(_ sender: UIButton) {
        
        switch loginViewModel.validateUser() {
        case .Valid:
            // Navigation to HomeScreenViewController
            coordinator?.eventOccurred(with: .loginButtonTapped)
            // Success Alert
            AppAlerts.showCompleteSuccessUIAlert(on: self)
        case .Empty:
            // Button Shake
            sender.shake()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .Invalid:
            // Button Shake
            sender.shake()
            // Improper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        }
    }
    
    // MARK: - Helpers
    func configureData() {
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.usernameTxtField.delegate = self
        loginView.passwordTxtField.delegate = self
    }
}


extension LoginViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == loginView.usernameTxtField {
            loginViewModel.updateUsername(username: newString.trimmingCharacters(in: .whitespaces))
        } else if textField == loginView.passwordTxtField {
            loginViewModel.updatePassword(password: newString.trimmingCharacters(in: .whitespaces))
        }
        
        if (string == " " || string == "    ") {
            return false
        }
        
        return true
    }
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
