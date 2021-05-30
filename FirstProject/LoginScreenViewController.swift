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
    

    
//    Image
    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleToFill
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
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
     var usernameTxtField: UITextField = {
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
        btnLogin.backgroundColor = .orange
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
        
        setUpLoginImagecinstraints()
        setupLoginScreennText()
        setupUsernameTxtField()
        setupPasswordTxtField()
        setupbtnLogin()
    }
    
    func setUpLoginImagecinstraints() {
        view.addSubview(loginImageView)

            }
    
    //        Screen message
    func setupLoginScreennText() {
        

        view.addSubview(logScreennText)
        
        NSLayoutConstraint.activate([
            logScreennText.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            logScreennText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logScreennText.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    //        Username View
    func setupUsernameTxtField() {
                view.addSubview(usernameTxtField)
                
                NSLayoutConstraint.activate([
                    usernameTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 325),
                    usernameTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    usernameTxtField.widthAnchor.constraint(equalToConstant: 280),
                    usernameTxtField.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    
    //        Password View
    func setupPasswordTxtField() {
                view.addSubview(passwordTxtField)
                
                NSLayoutConstraint.activate([
                    passwordTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 390),
                    passwordTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    passwordTxtField.widthAnchor.constraint(equalToConstant: 280),
                    passwordTxtField.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    
    //        Button View
    func setupbtnLogin() {
                view.addSubview(btnLogin)

                NSLayoutConstraint.activate([
                    btnLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -295),
                    btnLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    btnLogin.widthAnchor.constraint(equalToConstant: 170),
                    btnLogin.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    

    // END of Functions to add subviews of first screen elements

    
    
// Function to set the preferences of the first screen
    func setUpView() {
//        view.backgroundColor = .gray
    }

}
//-----------------End Of First Screen Controller-----------------


//----------------- Controller for second screen-----------------
class SecondViewController: UIViewController {

    private lazy var secondLoginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondScreenBackImage: UIImageView = {
        let secondBackImage = UIImageView()
        secondBackImage.image = UIImage(named: "gradient")
        secondBackImage.contentMode = .scaleAspectFit
        secondBackImage.translatesAutoresizingMaskIntoConstraints = false
        return secondBackImage
    }()
    
    private lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "user")
        userImage.contentMode = .scaleAspectFit
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
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
        view.addSubview(secondLoginContentView)
        
        NSLayoutConstraint.activate([
            secondLoginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            secondLoginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            secondLoginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        setupSecondScreenBackImageConstraints()
        setupUserImageConstraints()
        setupUserGreetMessage()
        setupUpdateInfoButtonView()
        setupLogOutButtonView()
    }
    
    func setupSecondScreenBackImageConstraints() {
        view.addSubview(secondScreenBackImage)
        
        NSLayoutConstraint.activate([
            secondScreenBackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
        ])
    }
    
    
    
    
    func setupUserImageConstraints() {
        view.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.heightAnchor.constraint(equalToConstant: 150),
            userImage.widthAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    
    

    func setupUserGreetMessage() {
        view.addSubview(userGreetMessage)

        NSLayoutConstraint.activate([
            userGreetMessage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            userGreetMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

    }

    func setupUpdateInfoButtonView() {
        view.addSubview(updateUserDataBtn)

        NSLayoutConstraint.activate([
            updateUserDataBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 400),
            updateUserDataBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateUserDataBtn.heightAnchor.constraint(equalToConstant: 50),
            updateUserDataBtn.widthAnchor.constraint(equalToConstant: 250),
        ])

    }

    func setupLogOutButtonView() {
        view.addSubview(logOutBtn)

        NSLayoutConstraint.activate([
            logOutBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 465),
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
        changeUserData.font = changeUserData.font.withSize(40)
        changeUserData.textAlignment = .center
        changeUserData.textColor = .white
        
        return changeUserData
    }()
    
    private lazy var updateUsernameField: UITextField = {
       let updateUsername = UITextField()
        updateUsername.translatesAutoresizingMaskIntoConstraints = false
        updateUsername.backgroundColor = .white
        updateUsername.textColor = .black
        updateUsername.placeholder = "Update Username"
        updateUsername.borderStyle = .roundedRect
        updateUsername.textAlignment = .center
        return updateUsername
    }()
    
    private lazy var passwordUsernameField: UITextField = {
       let passwordUser = UITextField()
        passwordUser.translatesAutoresizingMaskIntoConstraints = false
        passwordUser.backgroundColor = .white
        passwordUser.textColor = .black
        passwordUser.placeholder = "Update Password"
        passwordUser.borderStyle = .roundedRect
        passwordUser.textAlignment = .center
        return passwordUser
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
        setupUpdateUsernameField()
        setupPasswordUsernameField()
        setupSaveUserInfoBtn()
    }
    
    func setupUpdateUsernameField() {
        view.addSubview(updateUsernameField)
        
        NSLayoutConstraint.activate([
            updateUsernameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
            updateUsernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateUsernameField.heightAnchor.constraint(equalToConstant: 50),
            updateUsernameField.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    func setupPasswordUsernameField() {
        view.addSubview(passwordUsernameField)
        
        NSLayoutConstraint.activate([
            passwordUsernameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 295),
            passwordUsernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordUsernameField.heightAnchor.constraint(equalToConstant: 50),
            passwordUsernameField.widthAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    func setupSaveUserInfoBtn() {
        view.addSubview(saveUserInfoBtn)
        
        NSLayoutConstraint.activate([
            saveUserInfoBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 380),
            saveUserInfoBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveUserInfoBtn.heightAnchor.constraint(equalToConstant: 50),
            saveUserInfoBtn.widthAnchor.constraint(equalToConstant: 170),
        ])
    }
    
    
    func setUpView() {
        view.backgroundColor = .gray
    }

}
//-----------------End Third View to update the user`s info-----------------

