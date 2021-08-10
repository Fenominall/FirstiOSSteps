//
//  ThirdViewController.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import Foundation
import UIKit

// -----------------START OF FOURTH VIEW CONTROLLER-----------------
class ThirdViewController: UIViewController {
    
//    Gradient Backgorund Image on the third screen
    private lazy var thirdBackImage: UIImageView = {
        let thirdBackImage = UIImageView()
        thirdBackImage.image = UIImage(named: "gradient2")
        thirdBackImage.translatesAutoresizingMaskIntoConstraints = false
        thirdBackImage.contentMode = .scaleToFill
        return thirdBackImage
    }()

//    Message for the USER to change the data
    private lazy var changeUserDataLabel: UILabel = {
        let changeUserDataLabel = UILabel()
        changeUserDataLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUserDataLabel.text = "Change your data"
        changeUserDataLabel.font = changeUserDataLabel.font.withSize(40)
        changeUserDataLabel.textAlignment = .center
        changeUserDataLabel.textColor = .white
        return changeUserDataLabel
    }()
    
// Text field to update user`s name
    private lazy var updateUsernameTextField: UITextField = {
        let updateUsernameTextField = UITextField()
        updateUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        updateUsernameTextField.backgroundColor = .white
        updateUsernameTextField.textColor = .black
        updateUsernameTextField.placeholder = "Update Username"
        updateUsernameTextField.borderStyle = .roundedRect
        updateUsernameTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updateUsernameTextField.delegate = self
        return updateUsernameTextField
    }()
   
// Text field to update user`s password
    private lazy var updatePasswordTextField: UITextField = {
        let updatePasswordTextField = UITextField()
        updatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        updatePasswordTextField.backgroundColor = .white
        updatePasswordTextField.textColor = .black
        updatePasswordTextField.placeholder = "Update Password"
        updatePasswordTextField.borderStyle = .roundedRect
        updatePasswordTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        updatePasswordTextField.delegate = self
        return updatePasswordTextField
    }()
    
//    Button to save user changed on the third screen
    private lazy var saveUserDataButton: UIButton = {
        let saveUserDataButton = UIButton(type: .system)
        saveUserDataButton.translatesAutoresizingMaskIntoConstraints = false
        saveUserDataButton.backgroundColor = .blue
        saveUserDataButton.setTitle("Update", for: .normal)
        saveUserDataButton.tintColor = .white
        saveUserDataButton.layer.cornerRadius = 5
        saveUserDataButton.clipsToBounds = true
        saveUserDataButton.isEnabled = false
        saveUserDataButton.addTarget(self, action: #selector(updateDataButton), for: .touchUpInside)
        return saveUserDataButton
    }()
    
//    MARK: UISwitch for dark mode
    private lazy var backGroundColorSwitcher: UISwitch = {
        let backGroundColorSwitcher = UISwitch()
        backGroundColorSwitcher.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        backGroundColorSwitcher.setOn(false, animated: true)
        backGroundColorSwitcher.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return backGroundColorSwitcher
    }()
    
    
//    MARK: DARK MODE LABEL
    private lazy var darkModeUiLabel: UILabel = {
        let darkModeUiLabel = UILabel()
        darkModeUiLabel.text = "Change to dark mode"
        darkModeUiLabel.font = darkModeUiLabel.font.withSize(30)
        darkModeUiLabel.textAlignment = .center
        darkModeUiLabel.textColor = .white
        return darkModeUiLabel
    }()

// Function to add setups for the third view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Keboard taggling
        observerKeyboardNotifications()
        
        setUpView()
        
        elementsOfThirdScreenUIStack()
        
    }

    
//    Switch Change
    @objc func switchChanged(paramTarget: UISwitch) {
        
        if paramTarget.isOn {
            view.backgroundColor = .black
            print("It`s ON!")
        } else {
            view.backgroundColor = .orange
            print("It`s OFF!")
        }
    }
    
//    Check editing in UITextFields
    @objc private func textFieldEditingChanged(_ sender: Any) {
        
        let updatedUsername = self.updateUsernameTextField.text
        let updatedPassword = self.updatePasswordTextField.text
        
        let isUpdatedUsername = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPassword = AppDataValidator.validatePassword(updatedPassword)
        
        if isUpdatedUsername && isUpdatedPassword {
            // #correct password
            saveUserDataButton.isEnabled = true
        } else {
            saveUserDataButton.isEnabled = false
        }
        print(updateUsernameTextField.text ?? "no value")
        print(updatePasswordTextField.text ?? "no value")
    }
    
//    Button to update UserDefaults and return back to the SecondViewController
    @objc private func updateDataButton() {
        
        let updatedUsername = self.updateUsernameTextField.text
        let updatedPassword = self.updatePasswordTextField.text
        
        let isUpdatedUsernameValid = AppDataValidator.validateUserName(updatedUsername)
        let isUpdatedPasswordValid = AppDataValidator.validatePassword(updatedPassword)
        
        
        if isUpdatedUsernameValid && isUpdatedPasswordValid {
            
            // # Vibration for success
            HapticsManager.shared.vibrateForType(for: .success)
            
            // # Success Alert
            AppAlerts.showIncompleteUpdatedDataAlert(on: self)

        } else {
            
            // # Vibration for the Error
            HapticsManager.shared.vibrateForType(for: .error)
            
            // # Error Alert
            AppAlerts.showIncompleteErrorUIAlert(on: self)

        }
        
    }
    
// Functions to add subviews of first screen elements
        
// Backgound image on the third View Controller
    func elementsOfThirdScreenUIStack() {
        
        let darkModeUIStackView = UIStackView(arrangedSubviews: [darkModeUiLabel, backGroundColorSwitcher])
        darkModeUIStackView.translatesAutoresizingMaskIntoConstraints = false
        darkModeUIStackView.axis = .horizontal
        darkModeUIStackView.distribution = .fill
        darkModeUIStackView.spacing = 15
        view.addSubview(darkModeUIStackView)
        
        NSLayoutConstraint.activate([
            darkModeUIStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            darkModeUIStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            darkModeUIStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
      
        let thirdScreenUIStack = UIStackView(
            arrangedSubviews: [changeUserDataLabel, updateUsernameTextField, updatePasswordTextField, saveUserDataButton, darkModeUIStackView])
        thirdScreenUIStack.translatesAutoresizingMaskIntoConstraints = false
        thirdScreenUIStack.axis = .vertical
        thirdScreenUIStack.distribution = .fillEqually
        thirdScreenUIStack.spacing = 20
        view.addSubview(thirdScreenUIStack)
        
        NSLayoutConstraint.activate([
            thirdScreenUIStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            thirdScreenUIStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            thirdScreenUIStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            thirdScreenUIStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            changeUserDataLabel.heightAnchor.constraint(equalToConstant: 50),
        ])

        
    }
    
// Function to stores background image of third screen
    func setUpView() {
        view.backgroundColor = .orange
    }
    
}

//-------------------END of constraints for the FOURTH screen-------------------

// -----------------END OF FOURTH VIEW CONTROLLER-----------------
//processing...
