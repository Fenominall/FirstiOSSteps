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
    
    private var loginViewModel = AuthenticationViewModel()
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
        configureUI()
        print(FileManager.getDocumentsDirectory())
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
        
        switch loginViewModel.validateUser(byUserAuthState: .login) {
        case .Valid:
            // Navigation to HomeScreenViewController
            coordinator?.eventOccurred(with: .loginButtonTapped)
        case .Empty:
            // Button Shake
            sender.shake()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .Invalid:
            // Button Shake
            sender.shake()
            // Improper credentials Alert
            AppAlerts.incorrectCredentials(on: self)
        case .UsernameAlreadyTaken:
            sender.shake()
            AppAlerts.incorrectCredentials(on: self)
        }
    }
    
    @objc private func handleShowSignUp() {
        coordinator?.eventOccurred(with: .goToRegisterController)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    func configureData() {
        loginView.usernameTxtField.delegate = self
        loginView.passwordTxtField.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.dontHaveAccountButton.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        // Binding TextFields to send data to the LoginViewModel in order to update a User model
        loginView.usernameTxtField.bind { [weak self] in
            self?.loginViewModel.updateUsername(username: $0.trimmingCharacters(in: .whitespaces))
        }
        loginView.passwordTxtField.bind { [weak self] in
            self?.loginViewModel.updatePassword(password: $0.trimmingCharacters(in: .whitespaces))
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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
    
    //# Function to move the Keyboard-up on the first page
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)

    }

    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
