//
//  RegistrationViewController.swift
//  FirstProject
//
//  Created by Fenominall on 1/27/22.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    
    // MARK: - Properties
    let registerView = RegistrationView()
    private var loginViewModel = AuthenticationViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureActions()
        observeKeyboardNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerView.usernameTxtField.addBottomBorder()
        registerView.passwordTxtField.addBottomBorder()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogIn() {
        coordinator?.eventOccurred(with: .goToLoginController)
    }
    
    @objc func registerButtonPressed(_ sender: UIButton) {
        registerView.signUpIndicator.startAnimating()
        // Getting entered username to check if it already exists in the database or not
//        guard let username = registerView.usernameTxtField.text else { return }
//        loginViewModel.checkIfUserAlreadyCreated(byUsername: username)
        
        switch loginViewModel.validateUser(byUserAuthState: .register) {
        case .Valid:
            registerView.signUpIndicator.stopAnimating()
            sender.shake()
            coordinator?.eventOccurred(with: .loginButtonTapped)
            // Success Alert
            AppAlerts.showCompleteSuccessUIAlert(on: self)
        case .Empty:
            // Button Shake
            sender.shake()
            registerView.signUpIndicator.stopAnimating()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .Invalid:
            // Button Shake
            sender.shake()
            registerView.signUpIndicator.stopAnimating()
            // Improper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        case .UsernameAlreadyTaken:
            sender.shake()
            registerView.signUpIndicator.stopAnimating()
            AppAlerts.usernameIsAlreadyTakenAlert(on: self)
        case .NoInternetConnection:
            sender.shake()
            registerView.signUpIndicator.stopAnimating()
            AppAlerts.noInternetConnectionAlert(on: self)
        }
    }
    
    // MARK: - Helpers
    func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func configureActions() {
        registerView.usernameTxtField.delegate = self
        registerView.passwordTxtField.delegate = self
        
        registerView.loginToAccountButton.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
        
        // Binding TextFields to send data to the LoginViewModel in order to update a User model
        registerView.usernameTxtField.bind { [weak self] in
            self?.loginViewModel.updateUsername(username: $0.trimmingCharacters(in: .whitespaces))
        }
        registerView.passwordTxtField.bind { [weak self] in
            self?.loginViewModel.updatePassword(password: $0.trimmingCharacters(in: .whitespaces))
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Keyboard handler functions to observe notifications from keyboard to hide or show it
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
