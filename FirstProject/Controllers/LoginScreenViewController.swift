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
        // # Delegate UITextFields
        usernameTxtField.delegate = self
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
        // # Delegate UITextFields
        passwordTxtField.delegate = self
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

// MARK: Instance of LoginViewModel
    private var loginViewModel: LoginViewModel!
    

// MARK: Instance of ValidationViewModel
//    private var validationViewModel: UsernamePasswordViewModel = UsernamePasswordViewModel()
    
    
// MARK: Function to add setups for the first view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Notifications for swhowing and hiding keyboard
        observeKeyboardNofitications()
        
        //# AutoLayout constraints
        firstViewControllerConstraints()
        
        
        //MARK: LOAD SAVED USER DATA, (Does`t WORK.)
        if loginViewModel != nil {
            self.loginViewModel.load()
        } 
    }
    
//  MARK: Handaling navigation controller to disable it
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
//        usernameTxtField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    
//  MARK:  Disabled autorotation for the FirstViewController
    override open var shouldAutorotate: Bool {
        return true
    }

    
    /// Function for loginButton: Check validation, saves the user data into UserDefaults, pushes the user to the SecondViewController if requirments suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(sender: Any) {
        
//        self.loginViewModel.username = self.usernameTxtField.text!
//        self.loginViewModel.password = self.passwordTxtField.text!

        
//        self.loginViewModel = LoginViewModel(username: username, password: password)
//        self.loginViewModel.save()
//         Check for UITextFields if it`s not empty then save it to UserDefaults
//        if ((username.count != 0) && (password.count != 0)) {
        
//        }
        
        let username = self.usernameTxtField.text
        let password = self.passwordTxtField.text
        
        let isUsernameValid = AppDataValidator.validateUserName(username)
        let isPasswordValid = AppDataValidator.validatePassword(password)

        if isUsernameValid && isPasswordValid {
            
            let secondVC = SecondViewController()
            self.navigationController?.pushViewController(secondVC, animated: true)
            
            self.successUIAlert(title: "Success", message: successAlertMessage, preferedStyle: .alert)
        } else {
            self.errorUIAlert(title: "Error", message: passwordRequirmentsAlertMessage, preferedStyle: .alert)
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

    
    
    //    MARK: UIAlerts for UITextField validations dependent on user interactions
    
    /// Alert for validation to inform the user about the "Incorrect input"
    /// - Parameters:
    ///   - title: Dismiss
    ///   - message: let passwordRequirmentsAlertMessage
    ///   - preferedStyle: .alert
    func errorUIAlert(title: String, message: String, preferedStyle: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .destructive) { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Alert for validation to inform the user "Success"
    /// - Parameters:
    ///   - title: Ok
    ///   - message: let successAlertMessage
    ///   - preferedStyle: .alert
    func successUIAlert(title: String, message: String, preferedStyle: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (action) in
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: # AlertsMessages
//        let errorAlertMessage = "Username or Password shouldnot be empty!"
    let successAlertMessage = "Your account created your are logged in"
    let passwordRequirmentsAlertMessage = """
                              Username should be at least (min-4, max-20) charachters long.
                              Password can be only digits and at least 1 special charechter, should contain (min-8, max-20) charachters long.
                              """

    
}

// MARK: -----------------END OF FIRST VIEW CONTROLLER-----------------
