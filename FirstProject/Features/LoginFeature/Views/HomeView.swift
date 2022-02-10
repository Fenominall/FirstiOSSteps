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
    private lazy var circleBackGroundForUserImage: BaseImageView = {
        let imageView = BaseImageView(with: .lightCircle)
        return imageView
    }()
    
    private lazy var plusIcon: BaseImageView = {
        let imageView = BaseImageView(with: .plusIcon)
        return imageView
    }()
    
    private lazy var homeScreenBackgroundImage: BaseImageView = {
        let imageView = BaseImageView(with: .homeBackgroundImage)
        return imageView
    }()
    
    // UILabels
    private(set) lazy var usernameLabel: UILabel = {
        let greetMessage = UIViewTemplates().newUILabel(text: "",
                                                        fontSize: 40,
                                                        fontWeight: .bold,
                                                        textAlignment: .center,
                                                        textColor: .white)
        greetMessage.contentMode = .scaleAspectFit
        greetMessage.numberOfLines = 1
        return greetMessage
    }()
    
    // UIButtons
    private(set) lazy var uploadImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 150 / 2
        button.clipsToBounds = true
        let userImage = AppImages.userDefaultImage.image
        button.setImage(userImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    private(set) lazy var sourceCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.setTitle("GitHub", for: .normal)
        button.tintColor = .lightGrayAccent
        return button
    }()

    private func customUIButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.configuration = .lightGrayButton()
        button.setTitle(title, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 0.5
        return button
    }

    private(set) lazy var editProfileButton = customUIButton(title: "Edit Profile")
    private(set) lazy var scheduleEventListButton = customUIButton(title: "Scheduler")
   
    // UIStackVies
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [editProfileButton, scheduleEventListButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        return buttonsStackView
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
    
    
    // MARK: - Helpers
    func configureUI() {
        
        addSubview(screenContainerUIView)
        screenContainerUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        screenContainerUIView.addSubview(homeScreenBackgroundImage)
        homeScreenBackgroundImage.snp.makeConstraints {
            $0.edges.equalTo(screenContainerUIView)
        }
        
        screenContainerUIView.addSubview(topContainerUIView)
        topContainerUIView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(screenContainerUIView)
            $0.height.equalTo(screenContainerUIView).multipliedBy(0.5)
        }
        
        screenContainerUIView.addSubview(bottomContainerUIView)
        bottomContainerUIView.snp.makeConstraints {
            $0.top.equalTo(topContainerUIView.snp.bottom)
            $0.leading.trailing.equalTo(topContainerUIView)
            $0.height.equalTo(screenContainerUIView).multipliedBy(0.5)
        }

        topContainerUIView.addSubview(circleBackGroundForUserImage)
        circleBackGroundForUserImage.snp.makeConstraints {
            $0.bottomMargin.equalTo(topContainerUIView.snp_bottomMargin)
            $0.centerX.equalTo(topContainerUIView.snp_centerXWithinMargins)
        }
        
        topContainerUIView.addSubview(usernameLabel)
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

        bottomContainerUIView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints {
            $0.topMargin.equalTo(bottomContainerUIView.snp_topMargin).inset(25)
            $0.leading.trailing.equalTo(bottomContainerUIView).inset(30)
          }

        circleBackGroundForUserImage.snp.makeConstraints {
            $0.width.height.equalTo(200)
        }
  
        addSubview(uploadImageButton)
        uploadImageButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(circleBackGroundForUserImage)
            $0.width.height.equalTo(150)
        }
        
        addSubview(plusIcon)
        plusIcon.snp.makeConstraints {
            $0.top.equalTo(uploadImageButton.snp_bottomMargin).inset(12)
            $0.trailing.equalTo(uploadImageButton.snp_trailingMargin).inset(12)
        }
        
        bottomContainerUIView.addSubview(sourceCodeButton)
        sourceCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerUIView.snp_bottomMargin)
            $0.centerX.equalTo(bottomContainerUIView.snp.centerX)
        }
    }
}
