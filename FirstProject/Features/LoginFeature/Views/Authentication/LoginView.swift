//
//  LoginScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 07.08.2021.
//
import UIKit
import SnapKit

class LoginView: UIView {
    
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
    private lazy var loginImageView: BaseImageView = {
        let imageView = BaseImageView(with: .loginBackgroundImage)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // UILables
    private lazy var loginScreenLabel: UILabel = {
        let label = UIViewTemplates().newUILabel(text: "Sign In",
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
        customTextField.enablePasswordToggle()
        return customTextField
    }()
    
    // UIButtons
    private(set) lazy var loginButton: UIButton = {
        let button = UIViewTemplates().customButton(title: "LOGIN",
                                                    fontSize: 40,
                                                    fontWeight: .regular,
                                                    tintColor: .white)
        return button
    }()
    
    private(set) lazy var dontHaveAccountButton: UIButton = {
        let button = UIViewTemplates().attributedButton("Don`t have account?", " Sign Up")
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
