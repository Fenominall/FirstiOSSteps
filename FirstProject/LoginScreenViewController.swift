//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import Foundation
import UIKit

// -----------------START OF FIRST VIEW CONTROLLER-----------------
class FirstViewController: UIViewController {
    
//    Backgound Image
    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()
    
//    Login Screen "Welcome!" Label
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
    
//    Username Placeholder
    private lazy var usernameTxtField: UITextField = {
        let usernameTxtField = UITextField()
        usernameTxtField.translatesAutoresizingMaskIntoConstraints = false
        usernameTxtField.backgroundColor = .white
        usernameTxtField.textColor = .black
        usernameTxtField.placeholder = "Username"
        usernameTxtField.borderStyle = .roundedRect
        return usernameTxtField
   }()

//    Password Placeholder
    private lazy var passwordTxtField: UITextField = {
        let passwordTxtField = UITextField()
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.backgroundColor = .white
        passwordTxtField.textColor = .black
        passwordTxtField.placeholder = "Password"
        passwordTxtField.borderStyle = .roundedRect
        return passwordTxtField
    }()
    
//    Notification Label to notify the user about textField Validations
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
    
// Navigation Controller for btnLogin to Login the user and move to the second screen
    @objc private func loginButtonPressed() {
        let rootVC = ThirdViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
//    Message to SignUp on the Register page
    private let dontHaveAccountLabel: UILabel = {
        let dontHaveAccountLabel = UILabel()
        dontHaveAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(
            string: "Dont have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        dontHaveAccountLabel.attributedText = attributedText
        dontHaveAccountLabel.textAlignment = .center
        return dontHaveAccountLabel
    }()
    
//     SignUp Button
    private let signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return signUpButton
    }()
    
// Navigation Controller for SignUPButton to navigate the user to register screen
    @objc private func signUpButtonPressed() {
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

// #########################################################
    
// UITextField validation
    private let minimumPasswordLength = 8
    private let maximumPasswordLength = 20
    private lazy var regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#-;:`<>|{}[]%])[a-Az-z~,.\\d$@$!%*?&#-;:`<>|{}[]%]]{\(minimumLength),}$"
    private let password = "VladTest123!"
    
// Function to add setups for the first view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNofitications()
        
        firstViewControllerConstraints()
        
        usernameTxtField.delegate = self
        passwordTxtField.delegate = self
        notificationLabel.numberOfLines = 0
    }
    
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
    
//    Disabled autorotation for the FirstViewController
    override open var shouldAutorotate: Bool {
        return false
    }

//-------------------Start of constraints for the first screen-------------------
   
// First
    func firstViewControllerConstraints() {
        view.addSubview(loginImageView)
        view.addSubview(notificationLabel)
        
        NSLayoutConstraint.activate([
            notificationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            notificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
//        UIStack to place login elments in the middle of the first screen"(ogScreennText, usernameTxtField, passwordTxtField, btnLogin)"
        
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
        
//        UIStack for elements to register a user
        let registerUserLabelAButton = UIStackView(
        arrangedSubviews: [dontHaveAccountLabel, signUpButton])
        registerUserLabelAButton.translatesAutoresizingMaskIntoConstraints = false
        registerUserLabelAButton.axis = .horizontal
        registerUserLabelAButton.distribution = .fill
        registerUserLabelAButton.spacing = 10
        registerUserLabelAButton.contentMode = .scaleAspectFit
        
        
        view.addSubview(registerUserLabelAButton)
        
        NSLayoutConstraint.activate([
            registerUserLabelAButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            registerUserLabelAButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
    
//    Function to move the Keyboardup on the first page
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
//    end of unction to move the Keyboardup on the first page
    
//-------------------End of constraints for the first screen-------------------
    
}

extension FirstViewController: UITextFieldDelegate {

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let isSucess = (textField.text == password)
        notificationLabel.text = isSucess ? "Success" : "Error"
        notificationLabel.textColor = isSucess ? .green : .red
        textField.resignFirstResponder()
        return true
    }
    
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
// -----------------END OF FIRST VIEW CONTROLLER-----------------

// -----------------START OF SECOND VIEW CONTROLLER-----------------

class SecondViewController: UIViewController {
    
    //    Backgound image on the first screen
    private lazy var registerScreenUIImage: UIImageView = {
        let registerScreenUImage = UIImageView()
        registerScreenUImage.translatesAutoresizingMaskIntoConstraints = false
        registerScreenUImage.image = UIImage(named: "neon")
        registerScreenUImage.contentMode = .scaleAspectFit
        return registerScreenUImage
    }()
    
    //    Register Screen "Register!" Message
    private lazy var registerScreenLabel: UILabel = {
        let registerLabel = UILabel()
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "REGISTER", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40), NSAttributedString.Key.foregroundColor: UIColor.white])
        registerLabel.attributedText = attributedText
        registerLabel.textAlignment = .center
        return registerLabel
    }()
    
    private lazy var usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.backgroundColor = .white
        usernameTextField.textColor = .black
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        return usernameTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .white
        passwordTextField.textColor = .black
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        return passwordTextField
    }()
    
    private lazy var confirmPasswordTextFiled: UITextField = {
        let confirmPasswordTextFiled = UITextField()
        confirmPasswordTextFiled.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextFiled.backgroundColor = .white
        confirmPasswordTextFiled.textColor = .black
        confirmPasswordTextFiled.placeholder = "Confirm Password"
        confirmPasswordTextFiled.borderStyle = .roundedRect
        return confirmPasswordTextFiled
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.backgroundColor = .orange
        registerButton.setTitle("Register", for: .normal)
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 5
        registerButton.clipsToBounds = true
        registerButton.isEnabled = false
        return registerButton
    }()
    
    
    private let alreadyHaveAccountLabel: UILabel = {
        let alreadyHaveAccount = UILabel()
        alreadyHaveAccount.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white])
        alreadyHaveAccount.attributedText = attributedText
        alreadyHaveAccount.textAlignment = .center
        return alreadyHaveAccount
    }()
    
    private let logInButton: UIButton = {
        let logInButton = UIButton(type: .system)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Log In", for: .normal)
        logInButton.addTarget(self, action: #selector(navToLoginScreen), for: .touchUpInside)
        return logInButton
    }()
        
    @objc private func navToLoginScreen() {
        let rootVC = FirstViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seUpView()
        ConstraintsForRegisterScreen() 
    }

    
    func ConstraintsForRegisterScreen() {
//         Background Image
        view.addSubview(registerScreenUIImage)
        
        let registerElementsUIStack = UIStackView(
        arrangedSubviews: [registerScreenLabel, usernameTextField, passwordTextField, confirmPasswordTextFiled, registerButton])
        registerElementsUIStack.translatesAutoresizingMaskIntoConstraints = false
        registerElementsUIStack.axis = .vertical
        registerElementsUIStack.distribution = .fillEqually
        registerElementsUIStack.spacing = 20
        
        view.addSubview(registerElementsUIStack)
        
        NSLayoutConstraint.activate([
            registerElementsUIStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerElementsUIStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerElementsUIStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerElementsUIStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        let LoginUserLabelUIStack = UIStackView(
        arrangedSubviews: [alreadyHaveAccountLabel, logInButton])
        LoginUserLabelUIStack.translatesAutoresizingMaskIntoConstraints = false
        LoginUserLabelUIStack.axis = .horizontal
        LoginUserLabelUIStack.distribution = .fill
        LoginUserLabelUIStack.spacing = 10
        LoginUserLabelUIStack.contentMode = .scaleAspectFit
        
        view.addSubview(LoginUserLabelUIStack)
        
        NSLayoutConstraint.activate([
            LoginUserLabelUIStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            LoginUserLabelUIStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }
}
// -----------------END OF SECOND VIEW CONTROLLER-----------------

// -----------------START OF THIRD VIEW CONTROLLER-----------------
class ThirdViewController: UIViewController {

//    Backgound image on the first screen
    private lazy var thirdScreenUIImage: UIImageView = {
        let secondBackImage = UIImageView()
        secondBackImage.image = UIImage(named: "gradient")
        secondBackImage.contentMode = .scaleAspectFit
        secondBackImage.translatesAutoresizingMaskIntoConstraints = false
        return secondBackImage
    }()
    
//    User default image on the second screen
    private lazy var userUImageView: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
//     Displaye the user`s name on the scond screen "processing..." to develop //
    private lazy var userGreetMessageLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.boldSystemFont(ofSize: 40)
        greetMessage.adjustsFontSizeToFitWidth = true
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
//        processing...
        return greetMessage
    }()
    
//    Button to the third screen to update the user`s name and password
    private lazy var updateUserDataButton: UIButton = {
        let updateUserDataBtn = UIButton(type: .system)
        updateUserDataBtn.translatesAutoresizingMaskIntoConstraints = false
        updateUserDataBtn.backgroundColor = .orange
        updateUserDataBtn.setTitle("Update personal info", for: .normal)
        updateUserDataBtn.tintColor = .white
        updateUserDataBtn.layer.cornerRadius = 5
        updateUserDataBtn.clipsToBounds = true
        updateUserDataBtn.addTarget(self, action: #selector(UpdateButtonPressed), for: .touchUpInside)
        return updateUserDataBtn
    }()
    
// Navigation Controller for updateUserDataBtn "Button" to move to the third screen where the user can update his username and password
    @objc private func UpdateButtonPressed() {
        let rootVC = FourthViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
// Log out Button to log out the user to the first screen
    private lazy var logOutUserButton: UIButton = {
        let logOutBtn = UIButton(type: .system)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.backgroundColor = .blue
        logOutBtn.tintColor = .white
        logOutBtn.layer.cornerRadius = 5
        logOutBtn.clipsToBounds = true
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.addTarget(self, action: #selector(LogOutUserPressed), for: .touchUpInside)
        return logOutBtn
    }()
    
//    Navigation Button to FirstViewController
    @objc private func LogOutUserPressed() {
        let rootVC = FirstViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
//    Container to autolayout two place two elements User Login and User image
    private let userImageContainerView: UIView = {
        let topImageContainer = UIView(frame: .zero)
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
        return topImageContainer
    }()
    
//    Containter to autoplace button under the frinst autolayout container
    private let buttonsContainerView: UIView = {
        let buttonsContainerView = UIView(frame: .zero)
        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsContainerView
    }()
    
// Function to add setups for the second view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Constraints of the second screen
        setupSecondScreenBackImageConstraints()
    }

    
//-------------------Start of constraints for the second screen-------------------
// Functions to add subviews of first second elements

    
    
////    Constraints for the background image on the second screen
    func setupSecondScreenBackImageConstraints() {
//         ThirdScreenUIImage
        view.addSubview(thirdScreenUIImage)
        
        NSLayoutConstraint.activate([
            secondScreenBackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            secondScreenBackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
        ])

        setupUserImageConstraints()
        setupConstraintsForUpdateLogOutButtons()
    }
    
    
//    Constraints for the USER image on the second screen
    func setupUserImageConstraints() {
        
        
        view.addSubview(userImageContainerView)
        topImageContainerView.addSubview(userGreetMessageLabel)
        topImageContainerView.addSubview(userUImageView)


        NSLayoutConstraint.activate([

            topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            userGreetMessageLabel.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            userGreetMessageLabel.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            userGreetMessageLabel.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.75),

            userUImageView.heightAnchor.constraint(equalToConstant: 150),
            userUImageView.widthAnchor.constraint(equalToConstant: 150),
            userUImageView.topAnchor.constraint(equalTo: userGreetMessage.bottomAnchor),
            userUImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userUImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userUImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1),
        ])
    }

//    LOG OUT Button on the second screen
    func setupConstraintsForUpdateLogOutButtons() {
        
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(updateUserDataButton)
        buttonsContainerView.addSubview(logOutUserButton)

        NSLayoutConstraint.activate([
            buttonsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            buttonsContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            updateUserDataButton.topAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 30),
            updateUserDataButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updateUserDataButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            updateUserDataButton.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataButton.centerXAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor),

            //  Constraints for LOG OUT Button on the second screen
            logOutUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logOutUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logOutUserButton.heightAnchor.constraint(equalToConstant: 50),
            logOutUserButton.topAnchor.constraint(equalTo: updateUserDataBtn.bottomAnchor, constant: 15),
            logOutUserButton.centerXAnchor.constraint(equalTo: updateUserDataBtn.centerXAnchor),
        ])
    }
    
}

// -----------------END OF THIRD VIEW CONTROLLER-----------------


// -----------------START OF FOURTH VIEW CONTROLLER-----------------
class FourthViewController: UIViewController {
    
//    Gradient Backgorund Image on the third screen
    private lazy var thirdBackImage: UIImageView = {
        let thirdBackImage = UIImageView()
        thirdBackImage.image = UIImage(named: "gradient2")
        thirdBackImage.translatesAutoresizingMaskIntoConstraints = false
        thirdBackImage.contentMode = .scaleToFill
        return thirdBackImage
    }()

//    Message for the USER to change the data
    private lazy var changeUserDataLabel: UILabel = {
        let changeUserData = UILabel()
        changeUserDataLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUserDataLabel.text = "Change your data"
        changeUserDataLabel.font = changeUserData.font.withSize(40)
        changeUserDataLabel.textAlignment = .center
        changeUserDataLabel.textColor = .white
        return changeUserDataLabel
    }()
    
// Text field to update user`s name
    private lazy var updateUsernameTextField: UITextField = {
        let updateUsernameTextField = UITextField()
        updateUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        updateUsernameTextField.backgroundColor = .white
        updateUsernameTextField.textColor = .black
        updateUsernameTextField.placeholder = "Update Username"
        updateUsernameTextField.borderStyle = .roundedRect
        return updateUsernameTextField
    }()
   
// Text field to update user`s password
    private lazy var updatePasswordTextField: UITextField = {
        let updatePasswordTextField = UITextField()
        updatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        updatePasswordTextField.backgroundColor = .white
        updatePasswordTextField.textColor = .black
        updatePasswordTextField.placeholder = "Update Password"
        updatePasswordTextField.borderStyle = .roundedRect
        return updatePasswordTextField
    }()
    
//    Button to save user changed on the third screen
    private lazy var saveUserDataButton: UIButton = {
        let saveUserDataButton = UIButton(type: .system)
        saveUserDataButton.translatesAutoresizingMaskIntoConstraints = false
        saveUserDataButton.backgroundColor = .blue
        saveUserDataButton.setTitle("Update", for: .normal)
        saveUserDataButton.tintColor = .white
        saveUserDataButton.layer.cornerRadius = 5
        saveUserDataButton.clipsToBounds = true
        saveUserDataButton.isEnabled = false
        return saveUserDataButton
    }()

// Function to add setups for the third view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        ElementsOfThirdScreenUIStack()

    }

//-------------------Start of constraints for the FOURTH screen-------------------
// Functions to add subviews of first screen elements
        
// Backgound image on the third View Controller
    func ElementsOfThirdScreenUIStack() {
        let thirdScreenUIStack = UIStackView(
        arrangedSubviews: [changeUserDataLabel, updateUsernameTextField, updatePasswordTextField, saveUserDataButton])
        thirdScreenUIStack.translatesAutoresizingMaskIntoConstraints = false
        thirdScreenUIStack.axis = .vertical
        thirdScreenUIStack.distribution = .fillEqually
        thirdScreenUIStack.spacing = 20
        view.addSubview(thirdScreenUIStack)
        
        NSLayoutConstraint.activate([
            thirdScreenUIStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            thirdScreenUIStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            thirdScreenUIStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            thirdScreenUIStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
// Function to stores background image of third screen
    func setUpView() {
        view.addSubview(thirdBackImage)
    }
}

//-------------------END of constraints for the FOURTH screen-------------------

// -----------------END OF FOURTH VIEW CONTROLLER-----------------
//processing...
