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
    
    override func loadView() {
        super.loadView()
        view = userSettingsView
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Keyboard toggling
        observerKeyboardNotifications()
        textFieldsDelegates()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        userSettingsView.updateUsernameTextField.addBottomBorder()
        userSettingsView.updatePasswordTextField.addBottomBorder()
    }

    //    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {
        
        guard let updatedUsername =
                userSettingsView.updateUsernameTextField.text,
              let updatedPassword =
                userSettingsView.updatePasswordTextField.text else { return }
        
        let isUpdatedUsername = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPassword = AppDataValidator.validatePassword(updatedPassword)
        
        if isUpdatedUsername && isUpdatedPassword {
            userSettingsView.saveUserDataButton.isEnabled = true
        } else {
            userSettingsView.saveUserDataButton.isEnabled = false
        }
    }
    
    //    Button to update UserDefaults and return back to the SecondViewController
    @objc private func updateDataButton() {
        guard let updatedUsername =
                userSettingsView.updateUsernameTextField.text,
              let updatedPassword =
                userSettingsView.updatePasswordTextField.text else { return }
        
        let isUpdatedUsernameValid = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPasswordValid = AppDataValidator.validatePassword(updatedPassword)
        
        if isUpdatedUsernameValid && isUpdatedPasswordValid {
            // # Vibration for success
            HapticsManager.shared.vibrateForType(for: .success)
            // # Success Alert
            let successMessage = "Your data was successfully updated"
            let successUpdatedDataUIAlert = UIAlertController(title: "Success", message: successMessage, preferredStyle: .alert)
            successUpdatedDataUIAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) -> () in
                self?.coordinator?.eventOccurred(with: .updateUserDataButtonTapped)
            }))
            self.present(successUpdatedDataUIAlert, animated: true, completion: nil)
        } else {
            // # Vibration for the Error
            HapticsManager.shared.vibrateForType(for: .error)
            // # Error Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        }
        
    }
    
}


extension UserSettingsViewController {
    func textFieldsDelegates() {
        userSettingsView.updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.saveUserDataButton.addTarget(self, action: #selector(updateDataButton), for: .touchUpInside)
        
        userSettingsView.updateUsernameTextField.delegate = self
        userSettingsView.updatePasswordTextField.delegate = self
    }
}


extension UserSettingsViewController {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        (string == " " || string == "    ") ? false : true
    }
}

