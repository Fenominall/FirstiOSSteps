//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//
import Foundation
import UIKit


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

    private var loginViewModel = LoginViewModel()
    
    
    
    //MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Notifications for swhowing and hiding keyboard
        observeKeyboardNofitications()
        
        setDelegates()
        //# AutoLayout constraints
        configureLoginScreenUIElements()
        
        loginViewModel.username.bind {
            print("Username cahnged: \($0)")
        }
    }
    
    /// Function for loginButton: Check validation, saves the user data into UserDefaults, pushes the user to the SecondViewController if requirments suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed(_ sender: UIButton) {
        
        switch loginViewModel.validate() {
        case .Valid:
            loginViewModel.login()
            // SecondVC Navigation Controller
            let secondVC = SecondViewController()
            self.navigationController?.pushViewController(secondVC, animated: true)
            // Phone Vibrations
            HapticsManager.shared.vibrateForType(for: .success)
            // Success Alert
            AppAlerts.showIncompleteSuccessUIAlert(on: self)
           
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
            // Inproper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        }
    }
}

// MARK: -------------------UI Elements configuration-------------------
extension LoginScreenViewController {
    
    func setDelegates() {
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    func configureLoginScreenUIElements() {
        
        view.addSubview(containerView)
        containerView.addSubview(loginImageView)
        containerView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
}

extension LoginScreenViewController {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTxtField {
            textField.text = loginViewModel.username.value
        }
    }
    
//    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if textField == usernameTxtField {
            loginViewModel.updateUsername(username: newString.trimmingCharacters(in: .whitespaces))
        } else if textField == passwordTxtField {
            loginViewModel.updatePassword(password: newString.trimmingCharacters(in: .whitespaces))
        }

        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
}
