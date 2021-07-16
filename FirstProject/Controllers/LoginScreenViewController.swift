//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import Foundation
import UIKit



// MARK: Created keys for Username and Password for UserDefaults
//struct UserKeysDefaults {
//    static let keyUsername = "username"
//    static let keyPassword = "password"
//}

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
//        screenText.text = "WELCOME"
//        screenText.font = UIFont.boldSystemFont(ofSize: 40)
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

    
// MARK: Instance of LoginViewModel
    private var loginViewModel: LoginViewModel!

    
// MARK: Function to add setups for the first view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Notifications for swhowing and hiding keyboard
        observeKeyboardNofitications()
        
        // #
        firstViewControllerConstraints()
        
        // MARK: Function for UserDefaults for saving data
//        saveUsernameAndPassword()
        
        if loginViewModel != nil {
            self.loginViewModel.load()
        }
        
        // MARK: Defining number of lines for notificationLabel
        notificationLabel.numberOfLines = 0
        
        // #
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    

//   MARK: Save password in UITextField placeholders
//    private func saveUsernameAndPassword() {
//
//        if let enteredUsername = defaults.string(forKey: UserKeysDefaults.keyUsername) {
//            usernameTxtField.text = enteredUsername
//        }
//        if let enteredPassword = defaults.string(forKey: UserKeysDefaults.keyPassword) {
//            passwordTxtField.text = enteredPassword
//        }
//    }
    
// MARK: Navigation Controller for btnLogin to Login the user and move to the second screen
    @objc private func loginButtonPressed(sender: Any) {
        
        let username = self.usernameTxtField.text!
        let password = self.passwordTxtField.text!
        
//         Check for UITextFields if it`s not empty then save it to UserDefaults
//        if ((username.count != 0) && (password.count != 0)) {
            
//            defaults.setValue(username, forKey: UserKeysDefaults.keyUsername)
//            defaults.setValue(passwordTxtField.text!, forKey: UserKeysDefaults.keyPassword)
        
        
//        }
        self.loginViewModel = LoginViewModel(username: username, password: password)
        self.loginViewModel.save()

        let secondVC = SecondViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
   
    }
    
//  MARK: Handaling navigation controller to disable it
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
//  MARK:  Disabled autorotation for the FirstViewController
    override open var shouldAutorotate: Bool {
        return false
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
    
//  MARK:  Function to move the Keyboardup on the first page
    fileprivate func observeKeyboardNofitications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
//  MARK:  end of unction to move the Keyboardup on the first page
    
// MARK: -------------------End of constraints for the first screen-------------------

    
//  MARK: UITextField validation
    private let minimumPasswordLength = 8
    private let maximumPasswordLength = 20
    private lazy var regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#-;:`<>|{}[]%])[a-Az-z~,.\\d$@$!%*?&#-;:`<>|{}[]%]]{\(minimumPasswordLength),}$"
    private let password = "VladTest123!"
    
//     UITextField Validator
    private func checkValdiation(usernameTxtField: String) {
        guard usernameTxtField.count >= minimumPasswordLength else {
            notificationLabel.text = ""
            return
        }
        guard usernameTxtField.count <= maximumPasswordLength else {
            notificationLabel.text = ""
            return
        }
        if usernameTxtField.matches(regex) {
            notificationLabel.textColor = .green
            notificationLabel.text = "The password is valid"
        } else {
            notificationLabel.textColor = .white
            notificationLabel.text = "MIn \(minimumPasswordLength) symbols\nMax \(maximumPasswordLength) symbols \nShould contain: \n1 capital letter, \n1 lower case letter, \n1 number, \n1 special symbol"
        }
    }
}



extension LoginScreenViewController: UITextFieldDelegate {

//    Function that limits the number of characters in a UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  (string == " ") {
            return false
        }
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        checkValdiation(usernameTxtField: result)
        textField.text = result
        return false
    }
    
//    MARK: - Keyboard will hide if the user confirms that editing changed;
//    MARK: 2 - The notification will be shown based on checkValidation func;
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxtField || textField == passwordTxtField {
            self.usernameTxtField.resignFirstResponder()
            self.passwordTxtField.resignFirstResponder()
            let isSucess = (textField.text == password)
            notificationLabel.text = isSucess ? "Success" : "Error"
            notificationLabel.textColor = isSucess ? .green : .red
        }
        return true
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
// MARK: -----------------END OF FIRST VIEW CONTROLLER-----------------

