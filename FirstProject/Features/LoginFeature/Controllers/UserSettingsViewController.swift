//
//  ThirdViewController.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import Foundation
import UIKit

protocol UserSettingsDelegate: AnyObject {
    func updateUsername(username: String)
}

class UserSettingsViewController: UIViewController, Coordinating {
    
    // MARK: - Instance Properties
    var coordinator: Coordinator?
    var userSettingsView = UserSettingsView()
    private var loginViewModel = LoginViewModel()
    
    weak var delegate: UserSettingsDelegate?
    
    override func loadView() {
        super.loadView()
        view = userSettingsView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Keyboard toggling
        observeKeyboardNotifications()
        configureActions()
        configureNavigationBarUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userSettingsView.updateUsernameTextField.addBottomBorder()
        userSettingsView.updatePasswordTextField.addBottomBorder()
    }
    
    // MARK: - Selectors
    //    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {
        userSettingsView.saveUserDataButton.isEnabled = true
    }
    
    //    Button to update UserDefaults and return back to the SecondViewController
    @objc private func updateUserDataButton(_ sender: UIButton) {
        switch loginViewModel.validateUser() {
        case .Valid:
            // Navigation to HomeScreenViewController
            AppAlerts.updatedDataAlertTest(on: self) { [weak self]_ in
                guard let username = self?.userSettingsView.updateUsernameTextField.text else { return }
                // updating usernameLabel with received input in 
                self?.navigationController?.popViewController(animated: true)
                self?.delegate?.updateUsername(username: username)
            }
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
        case .UsernameAlreadyTaken:
            print("Test")
        }
    }
    
    // MARK: - Helpers
    
    func configureNavigationBarUI() {
        title = "Settings"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureActions() {
        userSettingsView.updateUsernameTextField.delegate = self
        userSettingsView.updatePasswordTextField.delegate = self
        
        userSettingsView.updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.saveUserDataButton.addTarget(self, action: #selector(updateUserDataButton), for: .touchUpInside)
        
        // Binding TextFields to send data to the LoginViewModel in order to update a User model
        userSettingsView.updateUsernameTextField.bind { [weak self] in
            self?.loginViewModel.updateUsername(username: $0.trimmingCharacters(in: .whitespaces))
        }
        userSettingsView.updatePasswordTextField.bind { [weak self] in
            self?.loginViewModel.updatePassword(password: $0.trimmingCharacters(in: .whitespaces))
        }
        
        // Assigning user data to textField in UserSettingsViewController
        userSettingsView.updateUsernameTextField.text = loginViewModel.username
        userSettingsView.updatePasswordTextField.text = loginViewModel.password
    }
}



// MARK: - UITextFieldDeledate
extension UserSettingsViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    //handle Dismiss/Hide The KeyBoard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
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

