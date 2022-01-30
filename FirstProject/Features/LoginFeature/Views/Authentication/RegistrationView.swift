//
//  RegistrationView.swift
//  FirstProject
//
//  Created by Fenominall on 1/27/22.
//

import UIKit
import SnapKit

class RegistrationView: UIView {

    // MARK: - Properties

    // UIViews
    private lazy var screenContainerUIView: UIView = {
        let view = UIViewTemplates().containerUIView()
        return view
    }()
    private lazy var topContainerUIView: UIView = {
        let view = UIViewTemplates().containerUIView()
        return view
    }()
    private lazy var bottomContainerUIView: UIView = {
        let view = UIViewTemplates().containerUIView()
        return view
    }()

    // UIImageViews
    private lazy var loginImageView: UIImageView = {
        let imageView = UIViewTemplates().imageView(image: AppImages.loginBackgroundImage)
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
        return customTextField
    }()

    private(set) lazy var passwordTxtField: CustomTextField = {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.isSecureTextEntry = true
//        customTextField.enablePasswordToggle()
        return customTextField
    }()

    // UIButtons
    private(set) lazy var registerButton: UIButton = {
        let button = UIViewTemplates().customButton(title: "REGISTER",
                                                    fontSize: 40,
                                                    fontWeight: .regular,
                                                    tintColor: .white)
        return button
    }()
    
    private(set) lazy var loginToAccountButton: UIButton = {
        let button = UIViewTemplates().attributedButton("Already have an account?", " Sign In")
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }



    // MARK: - Helpers
    func configureUI() {
        addSubview(screenContainerUIView)

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
