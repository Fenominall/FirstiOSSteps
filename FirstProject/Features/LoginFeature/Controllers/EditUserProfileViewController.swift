//
//  ThirdViewController.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import Foundation
import UIKit

protocol EditUserProfileDelegate: AnyObject {
    func didUpdatedUserUsername(withUsername: String)
}

class EditUserProfileViewController: UIViewController, Coordinating {
    
    // MARK: - Instance Properties
    var coordinator: Coordinator?
    private var editProfileViewModel = EditProfileViewModel()
    
    weak var delegate: EditUserProfileDelegate?
    
    // MARK: - UI Properties
    
    // MARK: UIView Container
    private lazy var containerUIView: FNLView = {
        let containerView = FNLView(frame: .zero)
        return containerView
    }()
    
    // MARK: - UIImageViews
    private lazy var backgroundImageView: FNLImageView = {
        let imageView = FNLImageView(with: .editProfileBackgroundImage)
        return imageView
    }()

    // MARK: - UILabels
    private lazy var changeUserDataLabel: FNLLabel = {
        let label = FNLLabel(with: "Change your data",
                             fontSize: 40,
                             fontWeight: .regular,
                             textColor: .lightGrayAccent ?? .white)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - UITextFields
    private lazy var usernameTextField: FNLTextField = {
        let textField = FNLTextField()
        textField.textColor = .white
        textField.clearButtonMode = .always
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: FNLTextField = {
        let textField = FNLTextField()
        textField.textColor = .white
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.enablePasswordToggle()
        textField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // MARK: - UIButtons
    private lazy var saveUserDataButton: FNLButton = {
        let button = FNLButton(title: "UPDATE",
                               fontSize: 40,
                               fontWeight: .regular,
                               titleColor: .white)
        button.isEnabled = false
        button.addTarget(self, action: #selector(updateUserDataButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - UIstackViews
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [changeUserDataLabel,
                                                              usernameTextField,
                                                              passwordTextField,
                                                              saveUserDataButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 40
        return contentStackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
        
        configureEditProfileController()
        didReceiveUserValidationState()
        failedUpdateUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameTextField.addBottomBorder()
        passwordTextField.addBottomBorder()
    }
    
    // MARK: - Selectors
    //    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {
        saveUserDataButton.isEnabled = true
    }
    
    @objc private func updateUserDataButtonTapped(_ sender: UIButton) {
        editProfileViewModel.updateUser(withUsername: usernameTextField.text,
                                        withPassword: passwordTextField.text)
    }
    
    // MARK: - Helpers
    
    func failedUpdateUser() {
        editProfileViewModel.onDidFailUpdateUser = { [weak self] in
            guard let self = self else { return }
            AppAlerts.failedUpdateUserAlert(on: self)
        }
    }
    
    func didReceiveUserValidationState() {
        editProfileViewModel.onDidFinishUserValidationState = { [weak self] state in
            self?.handleUserValidationState(state)
        }
    }
    
    func handleUserValidationState(_ state: UserValidationState) {
        switch state {
        case .valid:
            // Navigation to HomeScreenViewController
            AppAlerts.updatedDataAlert(on: self) { [weak self]_ in
                guard let username = self?.usernameTextField.text else { return }
                // updating usernameLabel with received input in
                self?.navigationController?.popViewController(animated: true)
                self?.delegate?.didUpdatedUserUsername(withUsername: username)
            }
        case .empty:
            // Button Shake
            saveUserDataButton.shake()
            // Empty fields Error Alert
            AppAlerts.emptyFieldsErrorAlert(on: self)
        case .invalid:
            saveUserDataButton.shake()
            // Improper credentials Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)
        case .usernameAlreadyTaken:
            saveUserDataButton.shake()
            AppAlerts.usernameIsAlreadyTakenAlert(on: self)
        case .noInternetConnection:
            saveUserDataButton.shake()
            AppAlerts.noInternetConnectionAlert(on: self)
        }
    }
    
    private func configureEditProfileController() {
        observeKeyboardNotifications()
        configureNavigationBar()
        configureActions()
        configureUI()
    }
    
    func configureNavigationBar() {
        title = "Settings"
        navigationItem.backButtonTitle = "Back"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureActions() {
        // Assigning user data to textField in UserSettingsViewController
        usernameTextField.text = editProfileViewModel.username
        passwordTextField.text = editProfileViewModel.password
    }
    
    func configureUI() {
        view.addSubview(containerUIView)
        containerUIView.addSubview(backgroundImageView)
        containerUIView.addSubview(contentStackView)
        
        containerUIView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(containerUIView)
        }
        
        contentStackView.snp.makeConstraints {
            $0.centerX.centerY.leading.trailing.equalToSuperview().inset(20)
        }
        
        changeUserDataLabel.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }
}

// MARK: - UITextFcurrentPFUserieldDeledate
extension EditUserProfileViewController: UITextFieldDelegate {
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    //handle Dismiss/Hide The KeyBoard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    //# Function to move the Keyboard-up on the first page
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc func keyboardWillShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}

