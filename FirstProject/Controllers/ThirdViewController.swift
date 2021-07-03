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
        updateUsernameTextField.addTarget(self, action: Selector(("textFieldEditingChanged:")), for: .editingChanged)
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
        updatePasswordTextField.addTarget(self, action: Selector(("textFieldEditingChanged:")), for: .editingChanged)
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
        saveUserDataButton.isEnabled = true
        saveUserDataButton.addTarget(self, action: #selector(updateDataButton), for: .touchUpInside)
        return saveUserDataButton
    }()

// Function to add setups for the third view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Keboard taggling
        observeKeyboardNofitications()
        
        setUpView()
        
        elementsOfThirdScreenUIStack()
        
        saveUpdatedUsernameAndPassword()
        
    }

    
    private func saveUpdatedUsernameAndPassword() {
        if let updateUsername = UserDefaults.standard.string(forKey: UserKeysDefaults.keyUsername) {
            updateUsernameTextField.text = updateUsername
        }
        if let updatePassword = UserDefaults.standard.string(forKey: UserKeysDefaults.keyPassword) {
            updatePasswordTextField.text = updatePassword
        }

    }
    
    
    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        print(updateUsernameTextField.text ?? "no value")
        print(updatePasswordTextField.text ?? "no value")
    }
    
    @objc private func updateDataButton() {
        let updatedUsername = updateUsernameTextField.text!
        let updatedPassword = updatePasswordTextField.text!
        
        defaults.setValue(updatedUsername, forKey: UserKeysDefaults.keyUsername)
        defaults.setValue(updatedPassword, forKey: UserKeysDefaults.keyPassword)
        
        let rootVC = SecondViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        
    }
    
// Functions to add subviews of first screen elements
        
// Backgound image on the third View Controller
    func elementsOfThirdScreenUIStack() {
        let thirdScreenUIStack = UIStackView(
        arrangedSubviews: [changeUserDataLabel, updateUsernameTextField, updatePasswordTextField, saveUserDataButton])
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
    }
    
// Function to stores background image of third screen
    func setUpView() {
        view.addSubview(thirdBackImage)
    }
    
    //    Function to move the content with the Keyboard
    fileprivate func observeKeyboardNofitications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -80, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
}

//-------------------END of constraints for the FOURTH screen-------------------

// -----------------END OF FOURTH VIEW CONTROLLER-----------------
//processing...
