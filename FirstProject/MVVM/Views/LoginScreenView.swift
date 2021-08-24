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

    private lazy var loginImageView: UIImageView = {
        let loginImage = UIImageView()
        loginImage.image = UIImage(named: "neon")
        loginImage.contentMode = .scaleAspectFit
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        return loginImage
    }()

    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [loginScreenLabel, usernameTxtField, passwordTxtField, loginButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.distribution = .fillEqually
        contentStackView.spacing = 20
        return contentStackView
    }()

    private lazy var loginScreenLabel: UILabel = {
        let loginScreenLabel = UILabel()
        loginScreenLabel.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(
            string: "WELCOME",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                         NSAttributedString.Key.foregroundColor: UIColor.white])
        loginScreenLabel.attributedText = attributedText
        loginScreenLabel.textAlignment = .center
        return loginScreenLabel
    }()

    private(set) lazy var usernameTxtField: UITextField = {
        let usernameTxtField = UITextField()
        usernameTxtField.translatesAutoresizingMaskIntoConstraints = false
        usernameTxtField.backgroundColor = .white
        usernameTxtField.textColor = .black
        usernameTxtField.placeholder = "Username"
        usernameTxtField.borderStyle = .roundedRect
        usernameTxtField.layer.borderWidth = 0
        return usernameTxtField
   }()

    private(set) lazy var passwordTxtField: UITextField = {
        let passwordTxtField = UITextField()
        passwordTxtField.translatesAutoresizingMaskIntoConstraints = false
        passwordTxtField.backgroundColor = .white
        passwordTxtField.textColor = .black
        passwordTxtField.placeholder = "Password"
        passwordTxtField.borderStyle = .roundedRect
        passwordTxtField.layer.borderWidth = 0
        return passwordTxtField
    }()

    private(set) lazy var loginButton: UIButton = {
        let btnLogin = UIButton(type:.system)
        btnLogin.backgroundColor = .orange
        btnLogin.setTitle("Login", for: .normal)
        btnLogin.tintColor = .white
        btnLogin.layer.cornerRadius = 5
        btnLogin.clipsToBounds = true
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
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
        containerUIView.addSubview(contentStackView)
        
        containerUIView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.centerX.centerY.leading.trailing.equalToSuperview().inset(20)
        }
    }

}