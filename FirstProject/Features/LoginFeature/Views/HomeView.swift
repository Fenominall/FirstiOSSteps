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
    private lazy var containerView = createUIView()
    private lazy var topContainerView = createUIView()
    private lazy var bottomContainerView = createUIView()
    
    // UIImageViews
    private lazy var circleBackGroundForUserImage = createUIImageView(withImage: AppImages.lightCircle)
    private lazy var plusIcon = createUIImageView(withImage: AppImages.plusIcon)
    private lazy var homeScreenBackgroundImage = createUIImageView(withImage: AppImages.homeBackgroundImage)

    // UILabels
    private(set) lazy var usernameLabel: UILabel = {
        let greetMessage = UILabel()
        greetMessage.translatesAutoresizingMaskIntoConstraints = false
        greetMessage.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        greetMessage.textAlignment = .center
        greetMessage.textColor = .white
        greetMessage.contentMode = .scaleAspectFit
        greetMessage.numberOfLines = 0
        return greetMessage
    }()
    
    // UIButtons
    private(set) lazy var uploadImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 150 / 2
        button.clipsToBounds = true
        button.setImage(AppImages.userImage, for: .normal)
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
        
        bottomContainerView.addSubview(sourceCodeButton)
        sourceCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerView.snp_bottomMargin)
            $0.centerX.equalTo(bottomContainerView.snp.centerX)
        }
    }
    
    private func createUIView() -> UIView {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func createUIImageView(withImage image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}

