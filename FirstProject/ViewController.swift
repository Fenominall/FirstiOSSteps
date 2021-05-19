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
       textField.backgroundColor = .white
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
        
        setUpView()
        setUpConstraints()

        view.addSubview(loginContentLabel)

        NSLayoutConstraint.activate([
            loginContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            loginContentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    func setUpConstraints() {
        view.addSubview(btnLogin)

        NSLayoutConstraint.activate([
            btnLogin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            btnLogin.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            btnLogin.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            btnLogin.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(usernameTxtField)
    }

    func setUpView() {
        view.backgroundColor = .gray
    }
    
}




