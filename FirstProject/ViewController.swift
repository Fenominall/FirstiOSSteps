//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//


import UIKit

class ViewController: UIViewController {
    
    private lazy var loginContentLabel: UILabel = {
        let loginLabel = UILabel(frame: .zero)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        return loginLabel
    }()
    
   private let usernameTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .white
       textField.placeholder = "Username"
       textField.borderStyle = .roundedRect
       return textField
   }()

   private let passwordTxtField: UITextField = {
       let textField = UITextField()
       textField.translatesAutoresizingMaskIntoConstraints = false
       textField.backgroundColor = .whote
       textField.placeholder = "Password"
       textField.borderStyle = .roundedRect
       return textField
   }()

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
        view.backgroundColor = .white
        
        // loginContentView.addSubview(usernameTxtField)
        // loginContentView.addSubview(passwordTxtField)
        // loginContentView.addSubview(btnLogin)

        view.addSubview(loginContentLabel)

        NSLayoutConstraint.activate([
            loginContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            Button
            // btnLogin.topAnchor.constraint(equalTo: loginContentView.bottomAnchor, constant: 450),
            // btnLogin.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 15),
            // btnLogin.rightAnchor.constraint(equalTo: loginContentView.rightAnchor, constant: -40),
            // btnLogin.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
}


