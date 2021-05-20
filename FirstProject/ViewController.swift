//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import UIKit


// First Screen Controller
class ViewController: UIViewController {
    
//    Screen View
    private lazy var loginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

//    Login Screen "Welcome!" Text
    private lazy let logScreennText: UILabel = {
        let screenText = UILabel()
        screenText.translatesAutoresizingMaskIntoConstraints = false
        screenText.text = "Welcome!"
        screenText.font = screenText.font.withSize(40)
        // screenText.textAlignment = .center
        screenText.textColor = .white
        return screenText
    }()
    
//    Username Text Field
   private var usernameTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.placeholder = "Username"
       textField.borderStyle = .roundedRect
       return textField
   }()

//    Password Text Field
   private var passwordTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.placeholder = "Password"
       textField.borderStyle = .roundedRect
       return textField
   }()

//    Button Text fields
    let btnLogin: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.backgroundColor = .blue
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        // btnLogin.addTarget(self, action: #seceltor(handleLoginTouchUpInside), for: .touchUpInside)
        return btnLogin

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConstraints()
        setUpView()
        

        view.addSubview(loginContentView)

        NSLayoutConstraint.activate([
            loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

// Function to add subviews of first screen elements
    func setUpConstraints() {
        
//        Screen message
        view.addSubview(logScreennText)
        
        NSLayoutConstraint.activate([
            logScreennText.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            logScreennText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 110),
            logScreennText.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
//        Username View
        view.addSubview(usernameTxtField)
        
        NSLayoutConstraint.activate([
            usernameTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 370),
            usernameTxtField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            usernameTxtField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            usernameTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])

//        Password View
        view.addSubview(passwordTxtField)
        
        NSLayoutConstraint.activate([
            passwordTxtField.topAnchor.constraint(equalTo: view.topAnchor, constant: 425),
            passwordTxtField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            passwordTxtField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            passwordTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
//        Button View
        view.addSubview(btnLogin)

        NSLayoutConstraint.activate([
            btnLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            btnLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            btnLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            btnLogin.heightAnchor.constraint(equalToConstant: 50)
        ])

        @objc func handleLoginTouchUpInside() {
            print("Login has been tapped")

        }
        
    }

    @IBAction func didTapButton() {
        present(SecondViewController(), animated: true)
    }

// Function to set the preferences of the first screen
    func setUpView() {
        view.backgroundColor = .gray
    }
    
}


class SecondViewController: UIViewController {

    private lazy var loginContentView:UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//     Displaye the user`s name on the scond screen
    private let userGreet: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey !"
        greetMessage.font = greetMessage.font.withSize(40)
        greetMessage.textColor = .white
        return greetMessage
    }()
    
//     Button to update the user`s info
    let updateUserDataBtn: UIButton =  {
        let updateUserDataBtn = UIButton(type:.system)
        updateUserDataBtn.translatesAutoresizingMaskIntoConstraints = false
        updateUserDataBtn.backgroundColor = .green
        updateUserDataBtn.setTitle("Update personal info", for: .normal)
        updateUserDataBtn.tintColor = .white
        updateUserDataBtn.layer.cornerRadius = 5
        updateUserDataBtn.clipsToBounds = true
        return updateUserDataBtn
    }()
    
//     Button to LogOut to the first screen
    let logOutBtn: UIButton = {
        let logOutBtn = UIButton(type:.system)
        logOutBtn.backgroundColor = .blue
        logOutBtn.setTitle("Log Out", for: .normal)
        logOutBtn.tintColor = .white
        logOutBtn.layer.cornerRadius = true
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        return logOutBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }


    func setUpView() {
        view.backgroundColor = .gray
    }

}
