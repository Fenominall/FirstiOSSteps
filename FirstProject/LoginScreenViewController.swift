//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import UIKit
import Foundation

// -----------------START OF FIRST VIEW CONTROLLER-----------------
class ViewController: UIViewController {
    
//    Screen View for the first controller
    private lazy var loginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    Backgound image on the first screen
    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()
    
//    Login Screen "Welcome!" Message
    private lazy var logScreennText: UILabel = {
        let screenText = UILabel()
        screenText.translatesAutoresizingMaskIntoConstraints = false
        screenText.text = "WELCOME"
        screenText.font = UIFont.boldSystemFont(ofSize: 40)
        screenText.textAlignment = .center
        screenText.textColor = .white
        return screenText
    }()
    
//    Username Text Field on the frist screen
    var usernameTxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
   }()

//    Password Text Fieldo n the frist screen
    private lazy var passwordTxtField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        return textField
        
    }()

//    Button Text fields to login the user
    private lazy var btnLogin: UIButton = {
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
    
// Function to add setups for the first view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginContentView()
        setUpView()
    }
    
//    Disabled autorotation for the fris5t screen
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
// Navigation Controller for btnLogin to Login the user and move to the second screen
    @objc private func loginButtonPressed() {
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

//-------------------Start of constraints for the first screen-------------------
// Functions to add subviews of first screen elements
    
//   First screen Login content Content View constraints
    func setupLoginContentView() {
        view.addSubview(loginContentView)

        NSLayoutConstraint.activate([
            loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
//        Constraints of all elements on the first screen
        setUpLoginImagecinstraints()
        setupLoginScreennText()
        setupUsernameTxtField()
        setupPasswordTxtField()
        setupbtnLogin()
    }
    
//    Constraints for the background image on the first screen
    func setUpLoginImagecinstraints() {
        view.addSubview(loginImageView)

            }
//    Constraints for the Welcome message on the first screen
    func setupLoginScreennText() {
        view.addSubview(logScreennText)
        
        NSLayoutConstraint.activate([
            logScreennText.topAnchor.constraint(equalTo: view.topAnchor, constant: 255),
            logScreennText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logScreennText.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
//    Constraints for the Username UITextField  on the first screen
    func setupUsernameTxtField() {
        view.addSubview(usernameTxtField)
        
        NSLayoutConstraint.activate([
            usernameTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 325),
            usernameTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTxtField.widthAnchor.constraint(equalToConstant: 340),
            usernameTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    Constraints for the password UITextField on the first screen
    func setupPasswordTxtField() {
        view.addSubview(passwordTxtField)
        
        NSLayoutConstraint.activate([
            passwordTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 385),
            passwordTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTxtField.widthAnchor.constraint(equalToConstant: 340),
            passwordTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    Constraints for the btnLogin on the first screen
    
    func setupbtnLogin() {
        view.addSubview(btnLogin)

        NSLayoutConstraint.activate([
            btnLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -295),
            btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnLogin.widthAnchor.constraint(equalToConstant: 340),
            btnLogin.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
//-------------------End of constraints for the first screen-------------------
    
    
// Function to set the preferences of the first screen
//    NOW USELESS
    func setUpView() {
//        view.backgroundColor = .gray
    }
}
// -----------------END OF FIRST VIEW CONTROLLER-----------------

// -----------------START OF SECOND VIEW CONTROLLER-----------------
class SecondViewController: UIViewController {

//    Screen View for the SECOND controller
    private lazy var secondLoginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    Backgound image on the first screen
    private lazy var secondScreenBackImage: UIImageView = {
        let secondBackImage = UIImageView()
        secondBackImage.image = UIImage(named: "gradient")
        secondBackImage.contentMode = .scaleAspectFit
        secondBackImage.translatesAutoresizingMaskIntoConstraints = false
        return secondBackImage
    }()
    
//    User default image on the second screen
    private lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    
//     Displaye the user`s name on the scond screen "processing..." to develop //
    private lazy var userGreetMessage: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.boldSystemFont(ofSize: 40)
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
//        processing...
        return greetMessage
    }()
    
//    Button to the third screen to update the user`s name and password
    private lazy var updateUserDataBtn: UIButton = {
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
    
// Log out Button to log out the user to the first screen
    private lazy var logOutBtn: UIButton = {
        let logOutBtn = UIButton(type: .system)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.backgroundColor = .blue
        logOutBtn.tintColor = .white
        logOutBtn.layer.cornerRadius = 5
        logOutBtn.clipsToBounds = true
        logOutBtn.setTitle("Log Out", for: .normal)
        return logOutBtn
    }()
    
// Function to add setups for the second view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Constraints of the second screen
        setupSecondLoginContentView()
        setUpView()
    }
    
// Navigation Controller for updateUserDataBtn "Button" to move to the third screen where the user can update his username and password
    @objc private func UpdateButtonPressed() {
        let rootVC = ThirdViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true)
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
//-------------------Start of constraints for the second screen-------------------
// Functions to add subviews of first second elements
    
    
//   Second screen content view constraints
    func setupSecondLoginContentView() {
        view.addSubview(secondLoginContentView)
        
        NSLayoutConstraint.activate([
            secondLoginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            secondLoginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            secondLoginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
//        Constraints of all elements on the second screen
        setupSecondScreenBackImageConstraints()
        setupUserImageConstraints()
        setupUserGreetMessage()
        setupUpdateInfoButtonView()
        setupLogOutButtonView()
    }
    
//    Constraints for the background image on the second screen
    func setupSecondScreenBackImageConstraints() {
        view.addSubview(secondScreenBackImage)
        
        NSLayoutConstraint.activate([
            secondScreenBackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            secondScreenBackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
        ])
    }
    
    
//    Constraints for the USER image on the second screen
    func setupUserImageConstraints() {
        view.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 150),
            userImage.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
// Display USER`S name constraints on the second screen
    func setupUserGreetMessage() {
        view.addSubview(userGreetMessage)

        NSLayoutConstraint.activate([
            userGreetMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            userGreetMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

//    UPDATE INFO button for the user
    func setupUpdateInfoButtonView() {
        view.addSubview(updateUserDataBtn)

        NSLayoutConstraint.activate([
            updateUserDataBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            updateUserDataBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateUserDataBtn.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataBtn.widthAnchor.constraint(equalToConstant: 250),
        ])

    }

//    LOG OUT Button on the second screen
    func setupLogOutButtonView() {
        view.addSubview(logOutBtn)

        NSLayoutConstraint.activate([
            logOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 465),
            logOutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutBtn.heightAnchor.constraint(equalToConstant: 50),
            logOutBtn.widthAnchor.constraint(equalToConstant: 250),
        ])
    }

    
// Function to add setups for the second view controller
//    NOW USELESS
    func setUpView() {
//        view.backgroundColor = .gray
    }
}

// -----------------END OF SECOND VIEW CONTROLLER-----------------


// -----------------START OF THIRD VIEW CONTROLLER-----------------
class ThirdViewController: UIViewController {
    
//    Gradient Backgorund Image on the third screen
    private lazy var thirdBackImage: UIImageView = {
        let thirdBackImage = UIImageView()
        thirdBackImage.image = UIImage(named: "gradient2")
        thirdBackImage.translatesAutoresizingMaskIntoConstraints = false
        thirdBackImage.contentMode = .scaleToFill
        return thirdBackImage
    }()

//    Message for the USER to change the data
    private lazy var changeUserData: UILabel = {
        let changeUserData = UILabel()
        changeUserData.translatesAutoresizingMaskIntoConstraints = false
        changeUserData.text = "Change your data"
        changeUserData.font = changeUserData.font.withSize(40)
        changeUserData.textAlignment = .center
        changeUserData.textColor = .white
        return changeUserData
    }()
    
// Text field to update user`s name
    private lazy var updateUsernameField: UITextField = {
        let updateUsername = UITextField()
        updateUsername.translatesAutoresizingMaskIntoConstraints = false
        updateUsername.backgroundColor = .white
        updateUsername.textColor = .black
        updateUsername.placeholder = "Update Username"
        updateUsername.borderStyle = .roundedRect
        return updateUsername
    }()
   
// Text field to update user`s password
    private lazy var passwordUsernameField: UITextField = {
        let passwordUser = UITextField()
        passwordUser.translatesAutoresizingMaskIntoConstraints = false
        passwordUser.backgroundColor = .white
        passwordUser.textColor = .black
        passwordUser.placeholder = "Update Password"
        passwordUser.borderStyle = .roundedRect
        return passwordUser
    }()
    
//    Button to save user changed on the third screen
    private lazy var saveUserInfoBtn: UIButton = {
        let saveUserInfoBtn = UIButton(type: .system)
        saveUserInfoBtn.translatesAutoresizingMaskIntoConstraints = false
        saveUserInfoBtn.backgroundColor = .blue
        saveUserInfoBtn.setTitle("Update", for: .normal)
        saveUserInfoBtn.tintColor = .white
        saveUserInfoBtn.layer.cornerRadius = 5
        saveUserInfoBtn.clipsToBounds = true
        return saveUserInfoBtn
    }()
    
// Function to add setups for the third view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupThirdBackImageConstraints()
        setUpView()
    }
    
//-------------------Start of constraints for the third screen-------------------
// Functions to add subviews of first screen elements
        
// Backgound image on the third View Controller
    func setupThirdBackImageConstraints() {
        view.addSubview(thirdBackImage)
        
        setupchangeUserData()
        setupUpdateUsernameField()
        setupPasswordUsernameField()
        setupSaveUserInfoBtn()
    }
        
    
//    Constraints for the "CHANGE YOUT DATA" message on the third screen
    func setupchangeUserData() {
        view.addSubview(changeUserData)
        
        NSLayoutConstraint.activate([
            changeUserData.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            changeUserData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

//    Constraints to update Username UITextField on the third screen
    func setupUpdateUsernameField() {
        view.addSubview(updateUsernameField)
        
        NSLayoutConstraint.activate([
            updateUsernameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            updateUsernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateUsernameField.heightAnchor.constraint(equalToConstant: 50),
            updateUsernameField.widthAnchor.constraint(equalToConstant: 340),
        ])
    }

//    Constraints to update Password UITextField on the third screen
    func setupPasswordUsernameField() {
        view.addSubview(passwordUsernameField)
        
        NSLayoutConstraint.activate([
            passwordUsernameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 290),
            passwordUsernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordUsernameField.heightAnchor.constraint(equalToConstant: 50),
            passwordUsernameField.widthAnchor.constraint(equalToConstant: 340),
        ])
    }
    
//    Constraints for the Update button on the third screen
    func setupSaveUserInfoBtn() {
        view.addSubview(saveUserInfoBtn)
        
        NSLayoutConstraint.activate([
            saveUserInfoBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 380),
            saveUserInfoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveUserInfoBtn.heightAnchor.constraint(equalToConstant: 50),
            saveUserInfoBtn.widthAnchor.constraint(equalToConstant: 340),
        ])
    }
    
// Function to set the preferences of the first screen
//    NOW USLESS
    func setUpView() {
//        view.backgroundColor = .gray
    }
    
}

    

//-------------------END of constraints for the third screen-------------------

// -----------------END OF FIRST VIEW CONTROLLER-----------------
//processing...
