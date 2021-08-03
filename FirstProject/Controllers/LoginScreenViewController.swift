//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import Foundation
import UIKit


// MARK: -----------------START OF FIRST VIEW CONTROLLER------------------
class LoginScreenViewController: UIViewController {

    
// MARK: Backgound Image
    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()
    
// MARK: Login Screen "Welcome!" Label
    private lazy var loginScreenLabel: UILabel = {
        let loginScreenLabel = UILabel()
        loginScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(
            string: "WELCOME",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                         NSAttributedString.Key.foregroundColor: UIColor.white])
        loginScreenLabel.attributedText = attributedText
        loginScreenLabel.textAlignment = .center
        return loginScreenLabel
    }()
    
//  MARK:  Username UITextField
    private lazy var usernameTxtField: UITextField = {
        let usernameTxtField = UITextField()
        usernameTxtField.translatesAutoresizingMaskIntoConstraints = false
        usernameTxtField.backgroundColor = .white
        usernameTxtField.textColor = .black
        usernameTxtField.placeholder = "Username"
        usernameTxtField.borderStyle = .roundedRect
        return usernameTxtField
   }()

//  MARK:  Password UITextField
    private lazy var passwordTxtField: UITextField = {
        let passwordTxtField = UITextField()
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.backgroundColor = .white
        passwordTxtField.textColor = .black
        passwordTxtField.placeholder = "Password"
        passwordTxtField.borderStyle = .roundedRect
        return passwordTxtField
    }()
    
//  MARK:  Notification Label to notify the user about textField Validations
    private lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.textAlignment = .center
        return notificationLabel
    }()

//    Login Button
    private lazy var loginButton: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.backgroundColor = .orange
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return btnLogin
    }()
    
    
    // MARK: LoginViewModel
    private var loginViewModel: LoginViewModel!
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Notifications for swhowing and hiding keyboard
        observeKeyboardNofitications()
        
        setDelegates()
        
        //# AutoLayout constraints
        firstViewControllerConstraints()
        
//        saveUsernameAndPassword()
        
    }
    
    func setDelegates() {
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
//  MARK: Handaling navigation controller to disable it
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
//        usernameTxtField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    //   MARK: Save password in UITextField placeholders
//        private func saveUsernameAndPassword() {
//
//            if let enteredUsername = defaults.string(forKey: UserKeysDefaults.keyUsername) {
//                usernameTxtField.text = enteredUsername
//            }
//            if let enteredPassword = defaults.string(forKey: UserKeysDefaults.keyPassword) {
//                passwordTxtField.text = enteredPassword
//            }
//        }
    
    /// Function for loginButton: Check validation, saves the user data into UserDefaults, pushes the user to the SecondViewController if requirments suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(sender: UIButton) {
                        
        
        
        let username = self.usernameTxtField.text!
        let password = self.passwordTxtField.text!
        
        
        let isUsernameValid = AppDataValidator.validateUserName(username)
        let isPasswordValid = AppDataValidator.validatePassword(password)
        
        
        if isUsernameValid && isPasswordValid {
            
            // Navigation controller
            let secondVC = SecondViewController()
            self.navigationController?.pushViewController(secondVC, animated: true)
            
            self.loginViewModel = LoginViewModel(username: username, password: password)
            self.loginViewModel.saveUserData()
                        
            
            // # Phone Vibration
            HapticsManager.shared.vibrateForType(for: .success)
            
            // # Success Alert
            AppAlerts.showIncompleteSuccessUIAlert(on: self)
            
        } else {
            
            // # Phone Vibration
            HapticsManager.shared.vibrateForType(for: .error)
            
            // # Button shake
            sender.shake()
            
            // # Error Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
            
            
        }
    }


// MARK: -------------------Start of constraints for the first screen-------------------
    
    func firstViewControllerConstraints() {
        view.addSubview(loginImageView)
        view.addSubview(notificationLabel)
        
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            notificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
// MARK: UIStack to place login elments in the middle of the first screen"(ogScreennText, usernameTxtField, passwordTxtField, btnLogin)"
        
        let centerControlStackView = UIStackView(
        arrangedSubviews: [loginScreenLabel, usernameTxtField, passwordTxtField, loginButton])
        centerControlStackView.translatesAutoresizingMaskIntoConstraints = false
        centerControlStackView.axis = .vertical
        centerControlStackView.distribution = .fillEqually
        centerControlStackView.spacing = 20
    
        view.addSubview(centerControlStackView)

        NSLayoutConstraint.activate([
            centerControlStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerControlStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            centerControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
// MARK: -------------------End of constraints for the first screen-------------------
    
}

// MARK: -----------------END OF FIRST VIEW CONTROLLER-----------------
