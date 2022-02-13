//
//  ViewController.swift
//  FirstProject
//
//  Created by Fenominall on 18.05.2021.
//
import Foundation
import SnapKit
import UIKit


class LoginViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var loginViewModel = LoginViewModel()
    
    // MARK: - UIProperties
    
    // UIViews
    private lazy var screenContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    private lazy var topContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    private lazy var bottomContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    
    // UIImageViews
    private lazy var loginImageView: FNLImageView = {
        let imageView = FNLImageView(with: .loginBackgroundImage)
        return imageView
    }()
    
    // UILables
    private lazy var loginScreenLabel: FNLLabel = {
        let label = FNLLabel(with: "Sign In",
                             fontSize: 45,
                             fontWeight: .semibold,
                             textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameLabel: FNLLabel = {
        let label = FNLLabel(with: "Username",
                             fontSize: 24,
                             fontWeight: .regular,
                             textColor: (.lightGrayAccent ?? .white))
        return label
    }()
    
    private lazy var passwordLabel: FNLLabel = {
        let label = FNLLabel(with: "Password",
                             fontSize: 24,
                             fontWeight: .regular,
                             textColor: (.lightGrayAccent ?? .white))
        return label
    }()
    
    // UITextFields
    private(set) lazy var usernameTxtField: CustomTextField = {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.clearButtonMode = .always
        customTextField.delegate = self
        customTextField.addBottomBorder()
        return customTextField
    }()
    
    private(set) lazy var passwordTxtField: CustomTextField = {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.delegate = self
        customTextField.isSecureTextEntry = true
        customTextField.enablePasswordToggle()
        return customTextField
    }()
    
    // UIButtons
    private(set) lazy var loginButton: FNLButton = {
        let button = FNLButton(title: "LOGIN",
                               fontSize: 40,
                               fontWeight: .regular,
                               titleColor: .white)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var dontHaveAccountButton: FNLAttributedButton = {
        let button = FNLAttributedButton("Don`t have account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    // UIActivityIndicator
    private(set) lazy var loginIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .white
        indicator.style = .large
        indicator.isHidden = true
        return indicator
    }()
    
    // UIStackViews
    private lazy var usernameStackView: UIStackView = {
        let usernameStackView = UIStackView(arrangedSubviews: [usernameLabel,
                                                               usernameTxtField])
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        usernameStackView.axis = .vertical
        usernameStackView.spacing = 10
        return usernameStackView
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,
                                                               passwordTxtField])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 10
        return passwordStackView
    }()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
        // Notifications for showing and hiding keyboard
        configureLoginViewController()
        didReceiveUserValidationState()
        print(FileManager.getDocumentsDirectory())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameTxtField.addBottomBorder()
        passwordTxtField.addBottomBorder()
    }
    
    // MARK: - Selectors
    /// Function for loginButton: Check validation, pushes the user to the SecondViewController if requirements suitable
    /// - Parameter sender: Any
    @objc private func loginButtonPressed() {
        loginIndicator.startAnimating()
        loginViewModel.loginUser(withUsername: usernameTxtField.text,
                                 withPassword: passwordTxtField.text)
    }
    
    @objc private func handleShowSignUp() {
        coordinator?.eventOccurred(with: .goToRegisterController)
    }
    
    // MARK: - Helpers
    
    private func didReceiveUserValidationState() {
        loginViewModel.onDidiFinishUserValidation = { [weak self] state in
            self?.handleUserValidationState(state)
        }
    }
    
    private func handleUserValidationState(_ state: UserValidationState) {
        switch state {
        case .valid:
            loginButton.shake()
            coordinator?.eventOccurred(with: .loginButtonTapped)
        case .empty:
            loginButton.shake()
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .invalid:
            loginButton.shake()
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        case .usernameAlreadyTaken:
            loginButton.shake()
            AppAlerts.incorrectCredentialsAlert(on: self)
        case .noInternetConnection:
            loginButton.shake()
            AppAlerts.noInternetConnectionAlert(on: self)
        }
        loginIndicator.stopAnimating()
    }
    
    private func configureLoginViewController() {
        configureNavigationBar()
        configureUI()
        observeKeyboardNotifications()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func configureUI() {
        view.addSubview(screenContainerUIView)
        
        screenContainerUIView.addSubview(loginImageView)
        screenContainerUIView.addSubview(topContainerUIView)
        screenContainerUIView.addSubview(bottomContainerUIView)
        
        topContainerUIView.addSubview(usernameStackView)
        topContainerUIView.addSubview(loginScreenLabel)
        
        bottomContainerUIView.addSubview(passwordStackView)
        bottomContainerUIView.addSubview(loginButton)
        bottomContainerUIView.addSubview(loginIndicator)
        bottomContainerUIView.addSubview(dontHaveAccountButton)
        
        screenContainerUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loginImageView.snp.makeConstraints {
            $0.edges.equalTo(screenContainerUIView)
        }
        
        topContainerUIView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(screenContainerUIView)
            $0.height.equalTo(screenContainerUIView).multipliedBy(0.5)
        }
        
        usernameStackView.snp.makeConstraints {
            $0.bottom.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom).inset(25)
            $0.leading.trailing.equalTo(topContainerUIView.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(topContainerUIView)
        }
        
        bottomContainerUIView.snp.makeConstraints {
            $0.top.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalTo(screenContainerUIView.safeAreaLayoutGuide)
            $0.height.equalTo(screenContainerUIView).multipliedBy(0.5)
        }
        
        passwordStackView.snp.makeConstraints {
            $0.top.equalTo(bottomContainerUIView.snp.top)
            $0.leading.trailing.equalTo(bottomContainerUIView.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(bottomContainerUIView)
        }
        
        loginScreenLabel.snp.makeConstraints {
            $0.centerY.equalTo(topContainerUIView).offset(-20)
            $0.leading.equalTo(topContainerUIView.snp.leading).inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalTo(bottomContainerUIView)
            $0.bottom.equalTo(dontHaveAccountButton.snp.bottom).offset(-70)
        }
        
        dontHaveAccountButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerUIView.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalTo(bottomContainerUIView)
        }
        
        loginIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalTo(bottomContainerUIView)
        }
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    //# Function to move the Keyboard-up on the first page
    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc private func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
