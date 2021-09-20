////////
////////  LoginScreenView.swift
////////  FirstProject
////////
////////  Created by Fenominall on 07.08.2021.
////////
//////
import UIKit
import SnapKit

class LoginScreenView: UIView {

    // MARK: UI Elements:
    // - containerView
    // - contentStackView
    // - Backgound Image
    // - Login Screen "Welcome!" Label
    // - Username UITextField
    // - Password UITextField
    
    private lazy var containerUIView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var topContainerUIView: UIView = {
        let topContainerUIView = UIView()
        topContainerUIView.translatesAutoresizingMaskIntoConstraints = false
        return topContainerUIView
    }()
    
    private lazy var bottomContainerUIView: UIView = {
        let bottomContainerUIView = UIView()
        bottomContainerUIView.translatesAutoresizingMaskIntoConstraints = false
        return bottomContainerUIView
    }()

    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "loginImage")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()
    
    private(set) lazy var appIconImageView: UIImageView = {
        let appIconImageView = UIImageView()
        appIconImageView.image = UIImage(named: "appIconF")
        appIconImageView.contentMode = .scaleAspectFit
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.dropShadow()
        return appIconImageView
    }()

    private lazy var usernameStackView: UIStackView = {
        let usernameStackView = UIStackView(arrangedSubviews: [usernameLabel ,usernameTxtField])
        usernameStackView.translatesAutoresizingMaskIntoConstraints = false
        usernameStackView.axis = .vertical
        usernameStackView.spacing = 10
        return usernameStackView
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTxtField])
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.axis = .vertical
        passwordStackView.spacing = 10
        return passwordStackView
    }()
    
    private(set) lazy var loginScreenLabel: UILabel = {
        let loginScreenLabel = UILabel()
        loginScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        loginScreenLabel.text = "Login"
        loginScreenLabel.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        loginScreenLabel.textAlignment = .center
        loginScreenLabel.textColor = .white
        return loginScreenLabel
    }()

    private lazy var usernameLabel: UILabel = {
        let usernameLabel = UILabel()
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = "Username"
        usernameLabel.textColor = lightGrayLogin
        usernameLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        return usernameLabel
    }()
    
    private lazy var passwordLabel: UILabel = {
        let passwordLabel = UILabel()
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Password"
        passwordLabel.textColor = lightGrayLogin
        passwordLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        
        return passwordLabel
    }()

    private(set) lazy var usernameTxtField: CustomTextField = {
        let userTxtField = CustomTextField()
        userTxtField.translatesAutoresizingMaskIntoConstraints = false
        userTxtField.textColor = .white
        return userTxtField
   }()
    
    private(set) lazy var passwordTxtField: CustomTextField = {
        let passwordTxtField = CustomTextField()
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.textColor = .white
        // adding a button in inside the TextField
        let overlayButton = UIButton(type: .system)
        let eyeImage = UIImage(systemName: "eye.fill")
        overlayButton.setImage(eyeImage, for: .normal)
        overlayButton.sizeToFit()
        overlayButton.tintColor = .white
        //
        passwordTxtField.rightView = overlayButton
        passwordTxtField.rightViewMode = .always
        return passwordTxtField
    }()

    private(set) lazy var loginButton: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("LOGIN", for: .normal)
        btnLogin.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        btnLogin.tintColor = .white
        return btnLogin
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()

    }

    // MARK: Configure UIElements     
    func configure() {
        addSubview(containerUIView)

        containerUIView.addSubview(loginImageView)
        containerUIView.addSubview(topContainerUIView)
        containerUIView.addSubview(bottomContainerUIView)

        topContainerUIView.addSubview(usernameStackView)
        topContainerUIView.addSubview(appIconImageView)
        topContainerUIView.addSubview(loginScreenLabel)
        topContainerUIView.addSubview(appIconImageView)
        
        bottomContainerUIView.addSubview(passwordStackView)
        bottomContainerUIView.addSubview(loginButton)
        
        containerUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        loginImageView.snp.makeConstraints {
            $0.edges.equalTo(containerUIView)
        }

        topContainerUIView.snp.makeConstraints {
            $0.edges.equalTo(containerUIView)
            $0.height.equalTo(containerUIView).multipliedBy(0.5)
        }

        usernameStackView.snp.makeConstraints {
            $0.bottom.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom).inset(25)
            $0.leading.trailing.equalTo(topContainerUIView.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(topContainerUIView)
        }

        bottomContainerUIView.snp.makeConstraints {
            $0.top.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalTo(containerUIView.safeAreaLayoutGuide)
            $0.height.equalTo(containerUIView).multipliedBy(0.5)
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
        
        appIconImageView.snp.makeConstraints {
            $0.top.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.top).inset(25)
            $0.trailing.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.trailing).inset(30)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalTo(bottomContainerUIView)
            $0.bottom.equalTo(bottomContainerUIView.safeAreaLayoutGuide.snp.bottom).offset(-70)
        }
        
        
        
        
    }
}


//class ButtonWithImage: UIButton {
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if imageView != nil {
//            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
//            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
//        }
//    }
//}
