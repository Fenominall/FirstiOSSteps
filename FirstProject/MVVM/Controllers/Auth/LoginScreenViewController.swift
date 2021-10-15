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
        // MARK: Notifications for showing and hiding keyboard
        observeKeyboardNotifications()
        
        shareLoginScreenView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        
        setDelegatesOfUITextFields()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.shareLoginScreenView.usernameTxtField.addBottomBorder()
        self.shareLoginScreenView.passwordTxtField.addBottomBorder()
        
    }
    
    /// Function for loginButton: Check validation, pushes the user to the SecondViewController if requirements suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(_ sender: UIButton) {
        
        switch loginViewModel.validateUser() {
            case .Valid:
                loginViewModel.login()
                // Navigation to HomeScreenViewController
                coordinator?.eventOccurred(with: .loginButtonTapped)
                // Success Alert
                afterBlock(seconds: 1) {
                    DispatchQueue.main.async {
                        AppAlerts.showIncompleteSuccessUIAlert(on: self)
                        print(Thread.current)
                    }
                }
                // Phone Vibrations
                HapticsManager.shared.vibrateForType(for: .success)
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
                // Improper credentials Alert
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

//  MARK: Handling navigation controller to disable it
extension LoginScreenViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}


// Function to to do something in some time
extension LoginScreenViewController {
    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> ()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
}
