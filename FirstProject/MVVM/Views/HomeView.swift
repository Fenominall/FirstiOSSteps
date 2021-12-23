//
//  HomeScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 20.08.2021.
//

import UIKit
import SnapKit

class HomeView: UIView, Coordinating {
    var coordinator: Coordinator?
    
    // MARK: - UIView Containers
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var topContainerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var bottomContainerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    // MARK: - UIImageViews
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
        userImage.contentMode = .scaleAspectFill
        userImage.layer.masksToBounds = false
        userImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        return userImage
    }()
    
    private lazy var plusIcon: UIImageView = {
        let plusIcon = UIImageView()
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        plusIcon.image = AppImages.plusIcon
        return plusIcon
    }()
    
    private(set) lazy var homeScreenBackgroundImage: UIImageView = {
        let userImage = UIImageView()
        userImage.image = AppImages.homeBackgroundImage
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    
    // MARK: - UILabels
    private(set) lazy var usernameLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.text = "Hey!"
        greetMessage.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
        greetMessage.numberOfLines = 0
        return greetMessage
    }()
    
    
    // MARK: - UIButtons
    
    private(set) lazy var uploadImageButton: UIButton = {
        let uploadImageButton = UIButton(type: .system)
        uploadImageButton.translatesAutoresizingMaskIntoConstraints = false
        uploadImageButton.layer.masksToBounds = false
        uploadImageButton.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        uploadImageButton.layer.cornerRadius = uploadImageButton.frame.size.width / 2
        uploadImageButton.clipsToBounds = true
        return uploadImageButton
    }()
    
    private(set) lazy var sourceCodeButton: UIButton = {
        let sourceCodeButton = UIButton(type: .system)
        sourceCodeButton.translatesAutoresizingMaskIntoConstraints = false
        sourceCodeButton.layer.masksToBounds = false
        sourceCodeButton.clipsToBounds = true
        sourceCodeButton.setTitle("GitHub", for: .normal)
        sourceCodeButton.tintColor = .lightGrayAccent
        return sourceCodeButton
    }()

    
    private func customUIButton(title: String) -> UIButton {
        let customUIButton = UIButton(type: .system)
        customUIButton.configuration = .lightGrayButton()
        customUIButton.setTitle(title, for: .normal)
        customUIButton.layer.shadowColor = UIColor.black.cgColor
        customUIButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        customUIButton.layer.shadowRadius = 2.0
        customUIButton.layer.shadowOpacity = 0.5
        return customUIButton
    }

    private(set) lazy var editProfileButton = customUIButton(title: "Edit Profile")
    private(set) lazy var scheduleEventListButton = customUIButton(title: "Scheduler")
   
    // MARK: - UIStackVies
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [editProfileButton, scheduleEventListButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        return buttonsStackView
    }()
    
    // MARK: UIView initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    
    // MARK: Configure auto-layout of UIElements
    func configureUI() {
        
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(homeScreenBackgroundImage)
        homeScreenBackgroundImage.snp.makeConstraints {
            $0.edges.equalTo(containerView)
        }
        
        containerView.addSubview(topContainerView)
        topContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(containerView)
            $0.height.equalTo(containerView).multipliedBy(0.5)
        }
        
        containerView.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints {
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.leading.trailing.equalTo(topContainerView)
            $0.height.equalTo(containerView).multipliedBy(0.5)
        }

        topContainerView.addSubview(circleBackGroundForUserImage)
        circleBackGroundForUserImage.snp.makeConstraints {
            $0.bottomMargin.equalTo(topContainerView.snp_bottomMargin)
            $0.centerX.equalTo(topContainerView.snp_centerXWithinMargins)
        }
        
        topContainerView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints {
            $0.bottomMargin.equalTo(circleBackGroundForUserImage.snp_topMargin).inset(-30)
            $0.centerX.equalTo(circleBackGroundForUserImage.snp_centerXWithinMargins)
        }
        
        addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        addSubview(scheduleEventListButton)
        scheduleEventListButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        bottomContainerView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.topMargin.equalTo(bottomContainerView.snp_topMargin).inset(25)
            $0.leading.trailing.equalTo(bottomContainerView).inset(30)
          }

        circleBackGroundForUserImage.snp.makeConstraints {
            $0.width.height.equalTo(200)
        }
        
        circleBackGroundForUserImage.addSubview(userUImageView)
        userUImageView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(circleBackGroundForUserImage)
            $0.width.height.equalTo(150)
        }
        
        addSubview(uploadImageButton)
        uploadImageButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(userUImageView)
            $0.width.height.equalTo(150)
        }
        
        addSubview(plusIcon)
        plusIcon.snp.makeConstraints {
            $0.top.equalTo(uploadImageButton.snp_bottomMargin).inset(12)
            $0.trailing.equalTo(uploadImageButton.snp_trailingMargin).inset(12)
        }
        
        bottomContainerView.addSubview(sourceCodeButton)
        sourceCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerView.snp_bottomMargin)
            $0.centerX.equalTo(bottomContainerView.snp.centerX)
        }
        
    }
}

