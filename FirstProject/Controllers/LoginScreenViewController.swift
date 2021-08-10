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
    
//     MARK: UI Elements:
//     - containerView
//     - contentStackView
//     - Backgound Image
//     - Login Screen "Welcome!" Label
//     - Username UITextField
//     - Password UITextField

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()

    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [loginScreenLabel, usernameTxtField, passwordTxtField, loginButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 20
        return contentStackView
    }()

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

    private lazy var usernameTxtField: UITextField = {
        let usernameTxtField = UITextField()
        usernameTxtField.translatesAutoresizingMaskIntoConstraints = false
        usernameTxtField.backgroundColor = .white
        usernameTxtField.textColor = .black
        usernameTxtField.placeholder = "Username"
        usernameTxtField.borderStyle = .roundedRect
        usernameTxtField.layer.borderWidth = 0
        return usernameTxtField
   }()

    private lazy var passwordTxtField: UITextField = {
        let passwordTxtField = UITextField()
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.backgroundColor = .white
        passwordTxtField.textColor = .black
        passwordTxtField.placeholder = "Password"
        passwordTxtField.borderStyle = .roundedRect
        passwordTxtField.layer.borderWidth = 0
        return passwordTxtField
    }()

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

    private var loginViewModel: LoginViewModel?
    
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

    /// Function for loginButton: Check validation, saves the user data into UserDefaults, pushes the user to the SecondViewController if requirments suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(_ sender: UIButton) {

        guard let username = usernameTxtField.text,
              let password = passwordTxtField.text else { return }

        let userNameTrimmingText = username.trimmingCharacters(in: .whitespaces)
        let passwordTrimmingText = password.trimmingCharacters(in: .whitespaces)

        let isUsernameValid = AppDataValidator.validateUserName(username)
        let isPasswordValid = AppDataValidator.validatePassword(password)


        if username.isEmpty && password.isEmpty {
            AppAlerts.emptyFieldsErrorAlert(on: self)
        }

        if username.isEmpty {
            AppAlerts.emptyUsernameErrorAlert(on: self)
        }

        if password.isEmpty {
            AppAlerts.emptyPasswordErrorAlert(on: self)
        }

        if isUsernameValid && isPasswordValid {


            self.loginViewModel = LoginViewModel(username: userNameTrimmingText, password: passwordTrimmingText)

            // Navigation controller
            let secondVC = SecondViewController()
            self.navigationController?.pushViewController(secondVC, animated: true)

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
        view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
// MARK: -------------------End of constraints for the first screen-------------------
    
}
