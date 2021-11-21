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
    
    
    
    //MARK: - ViewController lifecycle
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Notifications for showing and hiding keyboard
        observeKeyboardNotifications()
        initializeData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loginView.usernameTxtField.addBottomBorder()
        loginView.passwordTxtField.addBottomBorder()
        showData()
    }
    
    func showData() {
        loginViewModel.username.bind {
            print("Value Changed \($0)")
        }
    }
    
    
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
}

// MARK: - Configuring
extension LoginViewController {
    
    func initializeData() {
        navigationItem.setHidesBackButton(true, animated: false)
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.usernameTxtField.delegate = self
        loginView.passwordTxtField.delegate = self
    }
}


extension LoginViewController {
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
}
