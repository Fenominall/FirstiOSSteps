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
    private lazy var logScreennText: UILabel = {
        let screenText = UILabel()
        screenText.translatesAutoresizingMaskIntoConstraints = false
        screenText.text = "Welcome!"
        screenText.font = screenText.font.withSize(40)
        // screenText.textAlignment = .center
        screenText.textColor = .white
        return screenText
    }()
    
//    Username Text Field
   private let usernameTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.placeholder = "Username"
       textField.borderStyle = .roundedRect
       return textField
   }()

//    Password Text Field
   private let passwordTxtField: UITextField = {
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
        btnLogin.addTarget(self, action: #seceltor(handleLoginTouchUpInside), for: .touchUpInside)
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
// Function to set the preferences of the first screen
    func setUpView() {
        view.backgroundColor = .gray
    }
    
}

