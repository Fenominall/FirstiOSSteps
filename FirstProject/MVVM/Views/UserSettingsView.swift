//
//  UserSettingsView.swift
//  FirstProject
//
//  Created by Fenominall on 19.08.2021.
//

import UIKit
import SnapKit

class UserSettingsView: UIView {
    
    private lazy var containerUIView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [changeUserDataLabel, updateUsernameTextField, updatePasswordTextField, saveUserDataButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 20
        return contentStackView
    }()
    
    private lazy var darkModeUIStackView: UIStackView = {
        let darkModeUIStackView = UIStackView(arrangedSubviews: [darkModeUiLabel, backGroundColorSwitcher])
        darkModeUIStackView.translatesAutoresizingMaskIntoConstraints = false
        darkModeUIStackView.axis = .horizontal
        darkModeUIStackView.distribution = .fill
        darkModeUIStackView.spacing = 15
        return darkModeUIStackView
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
    private(set) lazy var updateUsernameTextField: UITextField = {
        let updateUsernameTextField = UITextField()
        updateUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        updateUsernameTextField.backgroundColor = .white
        updateUsernameTextField.textColor = .black
        updateUsernameTextField.placeholder = "Update Username"
        updateUsernameTextField.borderStyle = .roundedRect
        return updateUsernameTextField
    }()

    // Text field to update user`s password
    private(set) lazy var updatePasswordTextField: UITextField = {
        let updatePasswordTextField = UITextField()
        updatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        updatePasswordTextField.backgroundColor = .white
        updatePasswordTextField.textColor = .black
        updatePasswordTextField.placeholder = "Update Password"
        updatePasswordTextField.borderStyle = .roundedRect
        return updatePasswordTextField
    }()

    //    Button to save user changed on the third screen
    private(set) lazy var saveUserDataButton: UIButton = {
        let saveUserDataButton = UIButton(type: .system)
        saveUserDataButton.translatesAutoresizingMaskIntoConstraints = false
        saveUserDataButton.backgroundColor = .blue
        saveUserDataButton.setTitle("Update", for: .normal)
        saveUserDataButton.tintColor = .white
        saveUserDataButton.layer.cornerRadius = 5
        saveUserDataButton.clipsToBounds = true
        saveUserDataButton.isEnabled = false
        return saveUserDataButton
    }()

    //    MARK: UISwitch for dark mode
    private(set) lazy var backGroundColorSwitcher: UISwitch = {
        let backGroundColorSwitcher = UISwitch()
        backGroundColorSwitcher.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        backGroundColorSwitcher.setOn(false, animated: true)
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        elementsOfThirdScreenUIStack()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        elementsOfThirdScreenUIStack()
    }
    
    func elementsOfThirdScreenUIStack() {
        
        addSubview(containerUIView)
        containerUIView.addSubview(contentStackView)
        containerUIView.addSubview(darkModeUIStackView)
        
        containerUIView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.centerX.centerY.leading.trailing.equalToSuperview().inset(20)
        }
        
        changeUserDataLabel.snp.makeConstraints {
            $0.height.equalTo(50)
        }

        NSLayoutConstraint.activate([
            darkModeUIStackView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 10),
            darkModeUIStackView.centerXAnchor.constraint(equalTo: contentStackView.safeAreaLayoutGuide.centerXAnchor),
            darkModeUIStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
