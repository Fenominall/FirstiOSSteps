//
//  HomeScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 20.08.2021.
//

import UIKit
import SnapKit

class HomeView: UIView {
    
    
    private(set) lazy var circleBackGroundForUserImage: UIImageView = {
        let circleImage = UIImageView()
        circleImage.image = AppImages.lightCircle
        circleImage.translatesAutoresizingMaskIntoConstraints = false
        return circleImage
    }()
    
    private(set) lazy var userUImageView: UIImageView = {
        let userImage = UIImageView()
        userImage.image = AppImages.userImage
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.contentMode = .scaleAspectFit
        userImage.layer.masksToBounds = false
        userImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        return userImage
    }()
    
    private(set) lazy var homeScreenBackgroundImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = AppImages.homeBackgroundImage
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
        return greetMessage
    }()
    
    
    // MARK: - UIButtons
    private func customUIButton(title: String, backgroundColor: UIColor, tintColor: UIColor, cornerRadius: Int) -> UIButton {
        let customUIButton = UIButton(type: .system)
        customUIButton.translatesAutoresizingMaskIntoConstraints = false
        customUIButton.backgroundColor = backgroundColor
        customUIButton.setTitle(title, for: .normal)
        customUIButton.tintColor = tintColor
        customUIButton.layer.cornerRadius = CGFloat(cornerRadius)
        customUIButton.layer.shadowColor = UIColor.black.cgColor
        customUIButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        customUIButton.layer.shadowRadius = 2.0
        customUIButton.layer.shadowOpacity = 0.5
        return customUIButton
    }
    
    private(set) lazy var editProfileButton = customUIButton(title: "Edit Profile", backgroundColor: lightGrayLogin ?? .lightGray, tintColor: .white, cornerRadius: 5)
    private(set) lazy var sourceCodeButton = customUIButton(title: "App Source Code", backgroundColor: lightGrayLogin ?? .lightGray, tintColor: .white, cornerRadius: 5)
    private(set) lazy var logOutUserButton = customUIButton(title: "Log Out", backgroundColor: lightGrayLogin ?? .lightGray, tintColor: .white, cornerRadius: 5)
    
    // MARK: - UIStackVies
    private lazy var labelAndUserImageStack: UIStackView = {
        let labelAndUserImageStack = UIStackView(arrangedSubviews: [usernameLabel, circleBackGroundForUserImage])
        labelAndUserImageStack.translatesAutoresizingMaskIntoConstraints = false
        labelAndUserImageStack.axis = .vertical
        //        labelAndUserImageStack.distribution = .fillEqually
        labelAndUserImageStack.spacing = 10
        return labelAndUserImageStack
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [editProfileButton, sourceCodeButton, logOutUserButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        return buttonsStackView
    }()
    
    // MARK: UIView initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    // MARK: Configure auto-layout of UIElements
    func initialize() {
        addSubview(homeScreenBackgroundImage)
        homeScreenBackgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(labelAndUserImageStack)
        labelAndUserImageStack.snp.makeConstraints {
            $0.topMargin.centerXWithinMargins.equalToSuperview().inset(70)
        }
        
        addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        addSubview(sourceCodeButton)
        sourceCodeButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        addSubview(logOutUserButton)
        logOutUserButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(labelAndUserImageStack).inset(300)
            $0.left.right.equalToSuperview().inset(30)
        }
        
        circleBackGroundForUserImage.snp.makeConstraints {
            $0.width.height.equalTo(200)
        }
        
        circleBackGroundForUserImage.addSubview(userUImageView)
        userUImageView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(circleBackGroundForUserImage)
            $0.width.height.equalTo(150)
        }
    }
}

