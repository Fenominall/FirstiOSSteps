//
//  RegistrationViewController.swift
//  FirstProject
//
//  Created by Fenominall on 1/27/22.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var registerView = RegistrationView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = registerView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureActions()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerView.usernameTxtField.addBottomBorder()
        registerView.passwordTxtField.addBottomBorder()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func configureActions() {
        registerView.usernameTxtField.delegate = self
        registerView.passwordTxtField.delegate = self
        registerView.loginToAccountButton.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
    }
}
