//
//  ThirdViewController.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import Foundation
import UIKit

// -----------------START OF FOURTH VIEW CONTROLLER-----------------
class userSettingsController: UIViewController {

    var userSettingsView = UserSettingsView()

    override func loadView() {
        super.loadView()
        
        view = userSettingsView
    }
    
    // Lif eCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Keboard taggling
        observerKeyboardNotifications()
        
        setUpView()
        
        userSettingsView.updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        userSettingsView.saveUserDataButton.addTarget(self, action: #selector(updateDataButton), for: .touchUpInside)
        userSettingsView.backGroundColorSwitcher.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        userSettingsView.updatePasswordTextField.delegate = self
        userSettingsView.updatePasswordTextField.delegate = self
    }

    
//    Switch Change
    @objc func switchChanged(paramTarget: UISwitch) {
        if paramTarget.isOn {
            view.backgroundColor = .black
            print("It`s ON!")
        } else {
            view.backgroundColor = .orange
            print("It`s OFF!")
        }
    }
    
//    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {

        let updatedUsername = self.userSettingsView.updateUsernameTextField.text
        let updatedPassword = self.userSettingsView.updatePasswordTextField.text

        let isUpdatedUsername = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPassword = AppDataValidator.validatePassword(updatedPassword)

        if isUpdatedUsername && isUpdatedPassword {
            // #correct password
            userSettingsView.saveUserDataButton.isEnabled = true
        } else {
            userSettingsView.saveUserDataButton.isEnabled = false
        }
        print(userSettingsView.updateUsernameTextField.text ?? "no value")
        print(userSettingsView.updatePasswordTextField.text ?? "no value")
    }

//    Button to update UserDefaults and return back to the SecondViewController
    @objc private func updateDataButton() {

        let updatedUsername = userSettingsView.updateUsernameTextField.text
        let updatedPassword = userSettingsView.updatePasswordTextField.text

        let isUpdatedUsernameValid = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPasswordValid = AppDataValidator.validatePassword(updatedPassword)


        if isUpdatedUsernameValid && isUpdatedPasswordValid {

            // # Vibration for success
            HapticsManager.shared.vibrateForType(for: .success)

            // # Success Alert
            AppAlerts.showIncompleteUpdatedDataAlert(on: self)

        } else {

            // # Vibration for the Error
            HapticsManager.shared.vibrateForType(for: .error)

            // # Error Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)

        }

    }

// Function to stores background image of third screen
    func setUpView() {
        view.backgroundColor = .orange
    }

}
