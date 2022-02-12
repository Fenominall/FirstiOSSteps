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
    private var loginViewModel = RegistrationViewModel()
    
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
    private lazy var changeUserDataLabel: UILabel = {
        let changeUserDataLabel = UILabel()
        changeUserDataLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUserDataLabel.text = "Change your data"
        changeUserDataLabel.font = changeUserDataLabel.font.withSize(40)
        changeUserDataLabel.textAlignment = .center
        changeUserDataLabel.textColor = .lightGrayAccent
        return changeUserDataLabel
    }()
    
    // MARK: - UITextFields
    private(set) lazy var updateUsernameTextField: CustomTextField = {
        let updateUsernameTextField = CustomTextField()
        updateUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        updateUsernameTextField.textColor = .white
        updateUsernameTextField.clearButtonMode = .always
        updateUsernameTextField.delegate = self
        updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return updateUsernameTextField
    }()
    
    private(set) lazy var updatePasswordTextField: CustomTextField = {
        let updatePasswordTextField = CustomTextField()
        updatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        updatePasswordTextField.textColor = .white
        updatePasswordTextField.delegate = self
        updatePasswordTextField.isSecureTextEntry = true
        updatePasswordTextField.enablePasswordToggle()
        updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        return updatePasswordTextField
    }()
    
    // MARK: - UIButtons
    private(set) lazy var saveUserDataButton: UIButton = {
        let saveUserDataButton = UIButton(type: .system)
        saveUserDataButton.translatesAutoresizingMaskIntoConstraints = false
        saveUserDataButton.setTitle("UPDATE", for: .normal)
        saveUserDataButton.tintColor = .white
        saveUserDataButton.isEnabled = false
        saveUserDataButton.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        saveUserDataButton.layer.shadowColor = UIColor.black.cgColor
        saveUserDataButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        saveUserDataButton.layer.shadowRadius = 2.0
        saveUserDataButton.layer.shadowOpacity = 0.5
        saveUserDataButton.addTarget(self, action: #selector(updateUserDataButtonTapped), for: .touchUpInside)
        return saveUserDataButton
    }()
    
    // MARK: - UIstackViews
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [changeUserDataLabel,
                                                              updateUsernameTextField,
                                                              updatePasswordTextField,
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
        configureEditProfileController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUsernameTextField.addBottomBorder()
        updatePasswordTextField.addBottomBorder()
    }
    
    // MARK: - Selectors
    //    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {
        saveUserDataButton.isEnabled = true
    }
    
    @objc private func updateUserDataButtonTapped(_ sender: UIButton) {
        
//        guard let username = userSettingsView.updatePasswordTextField.text else { return }
//        loginViewModel.checkIfUserAlreadyCreated(byUsername: username
//        
//        )
    
//        switch loginViewModel.validateUser(byUserAuthState: .update) {
//        case .valid:
//            // Navigation to HomeScreenViewController
//            AppAlerts.updatedDataAlert(on: self) { [weak self]_ in
//                guard let username = self?.userSettingsView.updateUsernameTextField.text else { return }
//                // updating usernameLabel with received input in 
//                self?.navigationController?.popViewController(animated: true)
//                self?.delegate?.didUpdatedUserUsername(withUsername: username)
//            }
//        case .empty:
//            // Button Shake
//            sender.shake()
//            // Empty fields Error Alert
//            AppAlerts.emptyFieldsErrorAlert(on: self)
//        case .invalid:
//            sender.shake()
//            // Improper credentials Alert
//            AppAlerts.showIncompleteErrorUIAlert(on: self)
//        case .usernameAlreadyTaken:
//            sender.shake()
//            AppAlerts.usernameIsAlreadyTakenAlert(on: self)
//        case .noInternetConnection:
//            sender.shake()
//            AppAlerts.noInternetConnectionAlert(on: self)
//        }
    }
    
    // MARK: - Helpers
    
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
        updateUsernameTextField.text = loginViewModel.username
        updatePasswordTextField.text = loginViewModel.password
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

