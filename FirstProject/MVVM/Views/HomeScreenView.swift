//
//  HomeScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 20.08.2021.
//

import UIKit
import SnapKit

class HomeScreenView: UIView {
    
//    User default image on the second screen
    private(set) lazy var userUImageView: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "user")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.masksToBounds = false
        userImage.contentMode = .scaleAspectFit
        userImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        return userImage
    }()
    
    private(set) lazy var homeScreenBackgroundImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = UIImage(named: "blob-scene")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    private lazy var labelAndUserImageStack: UIStackView = {
        let labelAndUserImageStack = UIStackView(arrangedSubviews: [usernameLabel, userUImageView])
        labelAndUserImageStack.translatesAutoresizingMaskIntoConstraints = false
        labelAndUserImageStack.axis = .vertical
        labelAndUserImageStack.spacing = 40
        return labelAndUserImageStack
    }()
    
    private lazy var usernameLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.boldSystemFont(ofSize: 40)
        greetMessage.adjustsFontSizeToFitWidth = true
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
        return greetMessage
    }()
    
    private(set) lazy var updateUserDataButton: UIButton = {
        let updateUserDataBtn = UIButton(type: .system)
        updateUserDataBtn.translatesAutoresizingMaskIntoConstraints = false
        updateUserDataBtn.backgroundColor = lightGrayLogin
        updateUserDataBtn.setTitle("Update personal info", for: .normal)
        updateUserDataBtn.tintColor = .white
        updateUserDataBtn.layer.cornerRadius = 5
        updateUserDataBtn.clipsToBounds = true
        return updateUserDataBtn
    }()
    
    private(set) lazy var sourceCodeButton: UIButton = {
        let sourceCodeButton = UIButton(type: .system)
        sourceCodeButton.translatesAutoresizingMaskIntoConstraints = false
        sourceCodeButton.backgroundColor = lightGrayLogin
        sourceCodeButton.setTitle("App Source Code", for: .normal)
        sourceCodeButton.tintColor = .white
        sourceCodeButton.layer.cornerRadius = 5
        sourceCodeButton.clipsToBounds = true
        return sourceCodeButton
    }()
    
    private(set) lazy var logOutUserButton: UIButton = {
        let logOutBtn = UIButton(type: .system)
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.backgroundColor = lightGrayLogin
        logOutBtn.tintColor = .white
        logOutBtn.layer.cornerRadius = 5
        logOutBtn.clipsToBounds = true
        logOutBtn.setTitle("Log Out", for: .normal)
        return logOutBtn
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [updateUserDataButton, sourceCodeButton, logOutUserButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        return buttonsStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
//        backgroundColor = UIColor(red: 255/255, green: 170/255, blue: 0/255, alpha: 1)
        
        addSubview(homeScreenBackgroundImage)
        homeScreenBackgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(labelAndUserImageStack)
        labelAndUserImageStack.snp.makeConstraints {
            $0.topMargin.centerXWithinMargins.equalToSuperview().inset(70)
        }
        
        addSubview(updateUserDataButton)
        updateUserDataButton.snp.makeConstraints {
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
        
    
    }
}
