//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import UIKit
import Foundation


// -----------------First Screen Controller-----------------
class ViewController: UIViewController {
    
//    Screen View
    private lazy var loginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    Login Screen "Welcome!" Text
    private lazy var logScreennText: UILabel = {
        let screenText = UILabel()
        screenText.translatesAutoresizingMaskIntoConstraints = false
        screenText.text = "Welcome!"
        screenText.font = screenText.font.withSize(40)
        screenText.textAlignment = .center
        screenText.textColor = .white
        return screenText
    }()
    
//    Username Text Field
   private lazy var usernameTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.textColor = .black
       textField.placeholder = "Username"
       textField.borderStyle = .roundedRect
       return textField
   }()

//    Password Text Field
   private lazy var passwordTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.textColor = .black
       textField.placeholder = "Password"
       textField.borderStyle = .roundedRect
       return textField
   }()

//    Button Text fields
    private lazy var btnLogin: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.backgroundColor = .blue
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return btnLogin

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginContentView()
        setUpView()
    }
    
    
//Event neglder for btnLogin
    @objc private func loginButtonPressed() {
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

// Functions to add subviews of first screen elements
    
    
    //        Logic Content View
    func setupLoginContentView() {
        view.addSubview(loginContentView)

        NSLayoutConstraint.activate([
            loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        setupLoginScreennText()
        setupUsernameTxtField()
        setupPasswordTxtField()
        setupbtnLogin()
    }
    
    //        Screen message
    func setupLoginScreennText() {
        

        view.addSubview(logScreennText)
        
        NSLayoutConstraint.activate([
            logScreennText.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            logScreennText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110),
            logScreennText.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    //        Username View
    func setupUsernameTxtField() {
                view.addSubview(usernameTxtField)
                
                NSLayoutConstraint.activate([
                    usernameTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 370),
                    usernameTxtField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                    usernameTxtField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                    usernameTxtField.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    
    //        Password View
    func setupPasswordTxtField() {
                view.addSubview(passwordTxtField)
                
                NSLayoutConstraint.activate([
                    passwordTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 425),
                    passwordTxtField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
                    passwordTxtField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
                    passwordTxtField.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    
    //        Button View
    func setupbtnLogin() {
                view.addSubview(btnLogin)

                NSLayoutConstraint.activate([
                    btnLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -275),
                    btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                    btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                    btnLogin.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    

    // END of Functions to add subviews of first screen elements

    
    
// Function to set the preferences of the first screen
    func setUpView() {
        view.backgroundColor = .gray
    }

}
//-----------------End Of First Screen Controller-----------------


//----------------- Controller for second screen-----------------
class SecondViewController: UIViewController {

    private lazy var loginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//     Displaye the user`s name on the scond screen
     private lazy var userGreetMessage: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = greetMessage.font.withSize(40)
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        
        return greetMessage
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSecondLoginContentView()
        setupLogOutButtonView()
        setUpView()
    }
    
    
    
//Event neglder for btnLogin
    @objc private func UpdateButtonPressed() {
        let rootVC = ThirdViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    
    func setupSecondLoginContentView() {
        view.addSubview(userGreetMessage)
        
        NSLayoutConstraint.activate([
            userGreetMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            userGreetMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        setupUpdateInfoButtonView()
    }
    
    func setupUpdateInfoButtonView() {
        view.addSubview(updateUserDataBtn)
        
        NSLayoutConstraint.activate([
            updateUserDataBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            updateUserDataBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateUserDataBtn.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataBtn.widthAnchor.constraint(equalToConstant: 250),
        ])
        
    }
    
    func setupLogOutButtonView() {
        view.addSubview(logOutBtn)
        
        NSLayoutConstraint.activate([
            logOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 285),
            logOutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutBtn.heightAnchor.constraint(equalToConstant: 50),
            logOutBtn.widthAnchor.constraint(equalToConstant: 250),
        ])
        
    }


// Function to set the preferences of the second screen
    func setUpView() {
        view.backgroundColor = .gray
    }

}

//-----------------End of Controller for second screen-----------------


//-----------------Third View to update the user`s info-----------------
class ThirdViewController: UIViewController {
    
//    Message for the user to change the data
    private lazy var changeUserData: UILabel = {
       let changeUserData = UILabel()
        changeUserData.translatesAutoresizingMaskIntoConstraints = false
        changeUserData.text = "Change your data"
        changeUserData.font = changeUserData.font.withSize(24)
        changeUserData.textAlignment = .center
        changeUserData.textColor = .white
        
        return changeUserData
    }()
    
    private lazy var updateUsernameField: UITextField = {
       let updateUsername = UITextField()
        updateUsername.translatesAutoresizingMaskIntoConstraints = false
        updateUsername.backgroundColor = .white
        updateUsername.textColor = .black
        updateUsername.borderStyle = .roundedRect
        return updateUsername
    }()
    
    private lazy var passwordUsernameField: UITextField = {
       let passwordUsername = UITextField()
        passwordUsername.translatesAutoresizingMaskIntoConstraints = false
        passwordUsername.backgroundColor = .white
        passwordUsername.textColor = .black
        passwordUsername.borderStyle = .roundedRect
        return passwordUsername
    }()
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupchangeUserData()
        
        
        setUpView()
    }
        
    func setupchangeUserData() {
        
        view.addSubview(changeUserData)
        
        NSLayoutConstraint.activate([
            changeUserData.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            changeUserData.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setUpView() {
        view.backgroundColor = .gray
    }

}
//-----------------End Third View to update the user`s info-----------------

