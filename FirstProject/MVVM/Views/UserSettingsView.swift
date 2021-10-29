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
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "waves")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [changeUserDataLabel, updateUsernameTextField, updatePasswordTextField, saveUserDataButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 40
        return contentStackView
    }()

    //    Message for the USER to change the data
    private lazy var changeUserDataLabel: UILabel = {
        let changeUserDataLabel = UILabel()
        changeUserDataLabel.translatesAutoresizingMaskIntoConstraints = false
        changeUserDataLabel.text = "Change your data"
        changeUserDataLabel.font = changeUserDataLabel.font.withSize(40)
        changeUserDataLabel.textAlignment = .center
        changeUserDataLabel.textColor = lightGrayLogin
        return changeUserDataLabel
    }()
    
    // Text field to update user`s name
    private(set) lazy var updateUsernameTextField: CustomTextField = {
        let updateUsernameTextField = CustomTextField()
        updateUsernameTextField.translatesAutoresizingMaskIntoConstraints = false
        updateUsernameTextField.textColor = .white
        updateUsernameTextField.clearButtonMode = .always
        return updateUsernameTextField
    }()
    
    // Text field to update user`s password
    private(set) lazy var updatePasswordTextField: CustomTextField = {
        let updatePasswordTextField = CustomTextField()
        updatePasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        updatePasswordTextField.textColor = .white
        updatePasswordTextField.isSecureTextEntry = true
        updatePasswordTextField.enablePasswordToggle()
        return updatePasswordTextField
    }()

    //    Button to save user changed on the third screen
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
        return saveUserDataButton
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
