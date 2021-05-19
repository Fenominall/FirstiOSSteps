//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var loginContentView: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let myUsername: UITextField = UITextField(frame: CGRect(x: 25, y: 320, width: 320.00, height: 50.00));
    private let myPassword: UITextField = UITextField(frame: CGRect(x: 25, y: 380, width: 320.00, height: 50.00));
    
//    private let usernameTxtField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = UIColor.white
//        textField.placeholder = "Username"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let passwordTxtField: UITextField = {
//        let textField = UITextField()
//        textField.backgroundColor = .red
//        textField.placeholder = "Password"
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
    let btnLogin: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.backgroundColor = .blue
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        return btnLogin

    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLoginField()
        
        view.backgroundColor = .white
        
//        loginContentView.addSubview(usernameTxtField)
//        loginContentView.addSubview(passwordTxtField)
        loginContentView.addSubview(btnLogin)

        view.addSubview(loginContentView)

        NSLayoutConstraint.activate([
            loginContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            Button
            btnLogin.topAnchor.constraint(equalTo: loginContentView.bottomAnchor, constant: 450),
            btnLogin.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 15),
            btnLogin.rightAnchor.constraint(equalTo: loginContentView.rightAnchor, constant: -40),
            btnLogin.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func displayLoginField() {
//        Username 
        myUsername.placeholder = "Username"
        myUsername.borderStyle = UITextField.BorderStyle.line
        myUsername.backgroundColor = UIColor.white
        myUsername.textColor = UIColor.gray
        self.view.addSubview(myUsername)
//        Password
        myPassword.placeholder = "Password"
        myPassword.borderStyle = UITextField.BorderStyle.line
        myPassword.backgroundColor = UIColor.white
        myPassword.textColor = UIColor.gray
        myPassword.isSecureTextEntry = true
        self.view.addSubview(myPassword)
    }
    
}

