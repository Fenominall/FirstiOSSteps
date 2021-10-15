//
//  LoginScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 07.08.2021.
//

import UIKit
import SnapKit

class LoginScreenView: UIView {
    
    // MARK: - UIViews
    private func containerUIView() -> UIView {
        let containerUIView = UIView(frame: .zero)
        containerUIView.translatesAutoresizingMaskIntoConstraints = false
        return containerUIView
    }
    
    private lazy var screenContainerUIView = containerUIView()
    private lazy var topContainerUIView = containerUIView()
    private lazy var bottomContainerUIView = containerUIView()
    
    // MARK: - UIImageViews
    
    private func imageView(image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private lazy var loginImageView = imageView(image: "loginImage")
    private lazy var appIconImageView = imageView(image: "appIconF")
    
    // MARK: - UILables
    
    private func newUIlabel(text: String, fontSize: Int, fontWeight: UIFont.Weight, textAlignment: NSTextAlignment, textColor: UIColor) -> UILabel {
        let newUIlabel = UILabel()
        newUIlabel.translatesAutoresizingMaskIntoConstraints = false
        newUIlabel.text = text
        newUIlabel.textAlignment = textAlignment
        newUIlabel.textColor = textColor
        newUIlabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        return newUIlabel
    }
    
    private lazy var loginScreenLabel = newUIlabel(text: "Login", fontSize: 45, fontWeight: .semibold, textAlignment: .center, textColor: .white)
    private lazy var usernameLabel = newUIlabel(text: "Username", fontSize: 24, fontWeight: .regular, textAlignment: .natural, textColor: lightGrayLogin ?? .white)
    private lazy var passwordLabel = newUIlabel(text: "Password", fontSize: 24, fontWeight: .regular, textAlignment: .natural, textColor: lightGrayLogin ?? .white)
    
    // MARK: - UITextFields
    private func customTextField() -> CustomTextField {
        let customTextField = CustomTextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.textColor = .white
        customTextField.clearButtonMode = .always
        customTextField.clearButtonMode = .whileEditing
        return customTextField
    }
    
    
    private(set) lazy var usernameTxtField = customTextField()
    private(set) lazy var passwordTxtField = customTextField()
    
    
    // MARK: - UIButtons
    
    private func customButton(title: String, fontSize: Int, fontWeight: UIFont.Weight, tintColor: UIColor) -> UIButton {
        let customButton = UIButton(type:.system)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setTitle(title, for: .normal)
        customButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        customButton.tintColor = tintColor
        return customButton
    }
    
    private(set) lazy var loginButton = customButton(title: "LOGIN", fontSize: 40, fontWeight: .regular, tintColor: .white)
    
    
    // MARK: - UIStackViews
    
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
    
    // MARK: UIView initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        
    }
    
    // MARK: Configure auto-layout of UIElements
    func configure() {
        addSubview(screenContainerUIView)
        
        screenContainerUIView.addSubview(loginImageView)
        screenContainerUIView.addSubview(topContainerUIView)
        screenContainerUIView.addSubview(bottomContainerUIView)
        
        topContainerUIView.addSubview(usernameStackView)
        topContainerUIView.addSubview(appIconImageView)
        topContainerUIView.addSubview(loginScreenLabel)
        topContainerUIView.addSubview(appIconImageView)
        
        bottomContainerUIView.addSubview(passwordStackView)
        bottomContainerUIView.addSubview(loginButton)
        
        screenContainerUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loginImageView.snp.makeConstraints {
            $0.edges.equalTo(screenContainerUIView)
        }
        
        topContainerUIView.snp.makeConstraints {
            $0.edges.equalTo(screenContainerUIView)
            $0.height.equalTo(screenContainerUIView).multipliedBy(0.5)
        }
        
        usernameStackView.snp.makeConstraints {
            $0.bottom.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom).inset(25)
            $0.leading.trailing.equalTo(topContainerUIView.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(topContainerUIView)
        }
        
        bottomContainerUIView.snp.makeConstraints {
            $0.top.equalTo(topContainerUIView.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.bottom.equalTo(screenContainerUIView.safeAreaLayoutGuide)
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
