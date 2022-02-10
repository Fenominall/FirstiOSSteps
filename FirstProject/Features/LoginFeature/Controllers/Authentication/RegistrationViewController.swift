//
//  RegistrationViewController.swift
//  FirstProject
//
//  Created by Fenominall on 1/27/22.
//

import UIKit
import Parse

class RegistrationViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    
    // MARK: - Properties
    let registerView = RegistrationView()
    private var loginViewModel = RegistrationViewModel()
    
    // MARK: - UIProperties

    // UIViews
    private lazy var screenContainerUIView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var topContainerUIView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var bottomContainerUIView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // UIImageViews
    private lazy var loginImageView: BaseImageView = {
        let imageView = BaseImageView(with: .loginBackgroundImage)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // UILables
    private lazy var signUpLabel: UILabel = {
        let label = UIViewTemplates().newUILabel(text: "Sign Up",
                                                 fontSize: 45,
                                                 fontWeight: .semibold,
                                                 textAlignment: .center,
                                                 textColor: .white)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UIViewTemplates().newUILabel(text: "Username",
                                                 fontSize: 24,
                                                 fontWeight: .regular,
                                                 textAlignment: .natural,
                                                 textColor: .lightGrayAccent ?? .white)
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UIViewTemplates().newUILabel(text: "Password",
                                                 fontSize: 24,
                                                 fontWeight: .regular,
                                                 textAlignment: .natural,
                                                 textColor: .lightGrayAccent ?? .white)
        return label
    }()
        // UITextFields
    private(set) lazy var usernameTxtField: CustomTextField = {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.clearButtonMode = .always
        customTextField.delegate = self
        return customTextField
    }()

    private(set) lazy var passwordTxtField: CustomTextField = {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.delegate = self
//        customTextField.isSecureTextEntry = true
        return customTextField
    }()

    // UIButtons
    private(set) lazy var registerButton: UIButton = {
        let button = UIViewTemplates().customButton(title: "REGISTER",
                                                    fontSize: 40,
                                                    fontWeight: .regular,
                                                    tintColor: .white)
        button.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var loginToAccountButton: UIButton = {
        let button = UIViewTemplates().attributedButton("Already have an account?", " Sign In")
        button.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        return button
    }()
    
    // UIActivityIndicator
    private(set) lazy var signUpIndicator: UIActivityIndicatorView = {
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
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()

        configureNavigationBar()
        configureActions()
        observeKeyboardNotifications()
        handleUserActionsWithViewModel()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerView.usernameTxtField.addBottomBorder()
        registerView.passwordTxtField.addBottomBorder()
    }
    
    // MARK: - Selectors
    @objc func handleShowLogIn() {
        coordinator?.eventOccurred(with: .goToLoginController)
    }
    
    @objc func registerButtonPressed(_ sender: UIButton) {
        registerView.signUpIndicator.startAnimating()
        loginViewModel.signUpUserWith(username: registerView.usernameTxtField.text,
                                      password: registerView.passwordTxtField.text)
    }
    
    // MARK: - Helpers
    
    func handleUserActionsWithViewModel() {
        loginViewModel.onDidiFinishUserValidation = { [weak self] state in
            self?.handleValidationState(state)
        }
    }
    
    func handleValidationState(_ state: UserValidationState) {
        switch state {
        case .valid:
            registerView.signUpIndicator.stopAnimating()
            registerView.registerButton.shake()
            coordinator?.eventOccurred(with: .loginButtonTapped)
            // Success Alert
            AppAlerts.showCompleteSuccessUIAlert(on: self)
        case .empty:
            // Button Shake
            registerView.registerButton.shake()
            registerView.signUpIndicator.stopAnimating()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .invalid:
            // Button Shake
            registerView.registerButton.shake()
            registerView.signUpIndicator.stopAnimating()
            // Improper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        case .usernameAlreadyTaken:
            registerView.registerButton.shake()
            registerView.signUpIndicator.stopAnimating()
            AppAlerts.usernameIsAlreadyTakenAlert(on: self)
        case .noInternetConnection:
            registerView.registerButton.shake()
            registerView.signUpIndicator.stopAnimating()
            AppAlerts.noInternetConnectionAlert(on: self)
        }
    }
    
    func configureRegistrationViewController() {
        configureNavigationBar()
        configureUI()
        observeKeyboardNotifications()
    }
    
    func configureNavigationBar() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.barStyle = .black
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func configureActions() {
        registerView.usernameTxtField.delegate = self
        registerView.passwordTxtField.delegate = self
        
        registerView.loginToAccountButton.addTarget(self, action: #selector(handleShowLogIn), for: .touchUpInside)
        registerView.registerButton.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
    }
    
    func configureUI() {
        view.addSubview(screenContainerUIView)

        screenContainerUIView.addSubview(loginImageView)
        screenContainerUIView.addSubview(topContainerUIView)
        screenContainerUIView.addSubview(bottomContainerUIView)
        topContainerUIView.addSubview(usernameStackView)
        topContainerUIView.addSubview(signUpLabel)

        bottomContainerUIView.addSubview(passwordStackView)
        bottomContainerUIView.addSubview(registerButton)
        bottomContainerUIView.addSubview(loginToAccountButton)
        bottomContainerUIView.addSubview(signUpIndicator)

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

        signUpLabel.snp.makeConstraints {
            $0.centerY.equalTo(topContainerUIView).offset(-20)
            $0.leading.equalTo(topContainerUIView.snp.leading).inset(20)
        }

        registerButton.snp.makeConstraints {
            $0.centerX.equalTo(bottomContainerUIView)
            $0.bottom.equalTo(loginToAccountButton.snp.bottom).offset(-70)
        }

        loginToAccountButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerUIView.safeAreaLayoutGuide.snp.bottom)
            $0.centerX.equalTo(bottomContainerUIView)
        }
        
        signUpIndicator.snp.makeConstraints {
            $0.centerX.equalTo(bottomContainerUIView)
            $0.bottom.equalTo(registerButton.snp.top).inset(-20)
        }
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Keyboard handler functions to observe notifications from keyboard to hide or show it
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
