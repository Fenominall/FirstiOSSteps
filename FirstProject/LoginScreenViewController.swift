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
        let attributedText = NSMutableAttributedString(
            string: "WELCOME",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                         NSAttributedString.Key.foregroundColor: UIColor.white])
        screenText.attributedText = attributedText
//        Which method is more suitable?
//        screenText.text = "WELCOME"
//        screenText.font = UIFont.boldSystemFont(ofSize: 40)
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
    
//    Disabled autorotation for the frist screen
//    override open var shouldAutorotate: Bool {
//        return false
//    }
    
    
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
        view.addSubview(loginImageView)

        NSLayoutConstraint.activate([
            loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
//        Constraints of all elements on the first screen
        setupLoginScreennText()
    }

//    Constraints for the Welcome message on the first screen
    func setupLoginScreennText() {
        let centerControlStackView = UIStackView(
        arrangedSubviews: [logScreennText, usernameTxtField, passwordTxtField, btnLogin])
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
        greetMessage.adjustsFontSizeToFitWidth = true
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
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
    
//    Container to autolayout two place two elements User Login and User image
    private let topImageContainerView: UIView = {
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
    
    let stackViewTwoButtons: UIStackView = {
        let stackViewTwoButtons = UIStackView()
        stackViewTwoButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewTwoButtons.axis = .vertical
        stackViewTwoButtons.distribution = .equalSpacing
        return stackViewTwoButtons
    }()
    
// Function to add setups for the second view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Constraints of the second screen
        setupSecondScreenBackImageConstraints()
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
    
//    Constraints for the background image on the second screen
    func setupSecondScreenBackImageConstraints() {
        view.addSubview(secondScreenBackImage)
        
        NSLayoutConstraint.activate([
            secondScreenBackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            secondScreenBackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
        ])
        setupUserImageConstraints()
        setupConstraintsForUpdateLogOutButtons()
    }
    
    
//    Constraints for the USER image on the second screen
    func setupUserImageConstraints() {
        view.addSubview(topImageContainerView)
//        topImageContainerView.addSubview(stackViewTwoButtons)
        
        topImageContainerView.addSubview(userGreetMessage)
        topImageContainerView.addSubview(userImage)
        
        
        NSLayoutConstraint.activate([
//
//            topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
//            topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
//            topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

//            stackViewTwoButtons.topAnchor.constraint(equalTo: topImageContainerView.safeAreaLayoutGuide.topAnchor, constant: 30),
//            stackViewTwoButtons.centerXAnchor.constraint(equalTo: topImageContainerView.safeAreaLayoutGuide.centerXAnchor),
//            stackViewTwoButtons.centerYAnchor.constraint(equalTo: topImageContainerView.safeAreaLayoutGuide.centerYAnchor),
            
            
            userGreetMessage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor),
            userGreetMessage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            userGreetMessage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.75),

            userImage.heightAnchor.constraint(equalToConstant: 150),
            userImage.widthAnchor.constraint(equalToConstant: 150),
            userImage.topAnchor.constraint(equalTo: userGreetMessage.bottomAnchor),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1),
        ])
    }

//    LOG OUT Button on the second screen
    func setupConstraintsForUpdateLogOutButtons() {
        view.addSubview(stackViewTwoButtons)
        view.addSubview(buttonsContainerView)
        buttonsContainerView.addSubview(updateUserDataBtn)
        buttonsContainerView.addSubview(logOutBtn)

        NSLayoutConstraint.activate([
            buttonsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            buttonsContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //  Constraints for UPDATE Button on the second screen
            
            
            
            updateUserDataBtn.topAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor, constant: 30),
            updateUserDataBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updateUserDataBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            updateUserDataBtn.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataBtn.centerXAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor),
            
            //  Constraints for LOG OUT Button on the second screen
            
            logOutBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logOutBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            logOutBtn.heightAnchor.constraint(equalToConstant: 50),
            logOutBtn.topAnchor.constraint(equalTo: updateUserDataBtn.bottomAnchor, constant: 15),
            logOutBtn.centerXAnchor.constraint(equalTo: updateUserDataBtn.centerXAnchor),
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
        saveUserInfoBtn.isEnabled = false
        return saveUserInfoBtn
    }()
    
    
//    Containter to autoplace elemets on the third screen
    private let thirdScreenAutoLayoutView: UIView = {
        let thirdScreenAutoLayout = UIView()
        thirdScreenAutoLayout.translatesAutoresizingMaskIntoConstraints = false
        return thirdScreenAutoLayout
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
//        setupUpdateUsernameField()
//        setupPasswordUsernameField()
//        setupSaveUserInfoBtn()
    }
        
    
//    Constraints for the "CHANGE YOUT DATA" message on the third screen
    func setupchangeUserData() {
        view.addSubview(thirdScreenAutoLayoutView)
        thirdScreenAutoLayoutView.addSubview(changeUserData)
        thirdScreenAutoLayoutView.addSubview(updateUsernameField)
        thirdScreenAutoLayoutView.addSubview(passwordUsernameField)
        thirdScreenAutoLayoutView.addSubview(saveUserInfoBtn)
        
        NSLayoutConstraint.activate([
            thirdScreenAutoLayoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            thirdScreenAutoLayoutView.topAnchor.constraint(equalTo: view.topAnchor),
            thirdScreenAutoLayoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            thirdScreenAutoLayoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //    Constraints for the "CHANGE YOUT DATA" message on the third screen
            changeUserData.topAnchor.constraint(equalTo: thirdScreenAutoLayoutView.safeAreaLayoutGuide.topAnchor),
            changeUserData.centerXAnchor.constraint(equalTo: thirdScreenAutoLayoutView.centerXAnchor),
            changeUserData.centerYAnchor.constraint(equalTo: thirdScreenAutoLayoutView.centerYAnchor, constant: -20),
        
            //    Constraints to update Username UITextField on the third screen
            updateUsernameField.topAnchor.constraint(equalTo: changeUserData.safeAreaLayoutGuide.centerYAnchor, constant: 50),
            updateUsernameField.heightAnchor.constraint(equalToConstant: 50),
            updateUsernameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            updateUsernameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            updateUsernameField.centerXAnchor.constraint(equalTo: thirdScreenAutoLayoutView.centerXAnchor),
            
            //    Constraints to update Password UITextField on the third screen
            passwordUsernameField.topAnchor.constraint(equalTo: updateUsernameField.safeAreaLayoutGuide.bottomAnchor, constant: 15),
            passwordUsernameField.heightAnchor.constraint(equalToConstant: 50),
            passwordUsernameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordUsernameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordUsernameField.centerXAnchor.constraint(equalTo: thirdScreenAutoLayoutView.centerXAnchor),
            
        //    Constraints for the Update button on the third screen
            saveUserInfoBtn.topAnchor.constraint(equalTo: passwordUsernameField.safeAreaLayoutGuide.bottomAnchor, constant: 30),
            saveUserInfoBtn.heightAnchor.constraint(equalToConstant: 50),
            saveUserInfoBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            saveUserInfoBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            saveUserInfoBtn.centerXAnchor.constraint(equalTo: thirdScreenAutoLayoutView.centerXAnchor),
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
