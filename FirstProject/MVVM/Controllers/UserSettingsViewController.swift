//
//  ThirdViewController.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import Foundation
import UIKit

class UserSettingsViewController: UIViewController, Coordinating {
    
    // MARK: - Instance Properties
    var coordinator: Coordinator?
    var userSettingsView = UserSettingsView()
    var userSettingsViewModel = UserSettingsViewModel()
    
    override func loadView() {
        super.loadView()
        view = userSettingsView
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Keyboard toggling
        observerKeyboardNotifications()
        textFieldsDelegates()
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
        switch userSettingsViewModel.validateUser() {
        case .Valid:
            // Navigation to HomeScreenViewController
            AppAlerts.updatedDataAlertTest(on: self) { [weak self] _ in
                self?.coordinator?.eventOccurred(with: .updateUserDataButtonTapped)
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
        }
        
    }
    
    // MARK: - Helpers
    func textFieldsDelegates() {
        title = "Settings"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        userSettingsView.updateUsernameTextField.delegate = self
        userSettingsView.updatePasswordTextField.delegate = self
        
        userSettingsView.updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.saveUserDataButton.addTarget(self, action: #selector(updateUserDataButton), for: .touchUpInside)
   
    }
    
}

extension UserSettingsViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == userSettingsView.updateUsernameTextField {
            userSettingsViewModel.updateUsername(username: newString.trimmingCharacters(in: .whitespaces))
        } else if textField == userSettingsView.updatePasswordTextField {
            userSettingsViewModel.updatePassword(password: newString.trimmingCharacters(in: .whitespaces))
        }
        
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
    
}

