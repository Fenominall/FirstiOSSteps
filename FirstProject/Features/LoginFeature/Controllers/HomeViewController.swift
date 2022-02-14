//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//
import Photos
import PhotosUI
import UIKit
import Parse
import SnapKit

class HomeViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var imageStorage = ImageStorage()
    private var homeViewModel = HomeViewModel()
    var imagedToUpdate: UIImage?
        
    // MARK: UI Properties
    // UIViews
    private lazy var screenContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    
    private lazy var topContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    private lazy var bottomContainerUIView: FNLView = {
        let view = FNLView(frame: .zero)
        return view
    }()
    
    // UIImageViews
    private lazy var circleBackGroundForUserImage: FNLImageView = {
        let imageView = FNLImageView(with: .lightCircle)
        return imageView
    }()
    
    private lazy var plusIcon: FNLImageView = {
        let imageView = FNLImageView(with: .plusIcon)
        
        return imageView
    }()
    
    private lazy var homeScreenBackgroundImage: FNLImageView = {
        let imageView = FNLImageView(with: .homeBackgroundImage)
        return imageView
    }()
    
    private lazy var userIconImage: FNLImageView = {
        let image = FNLImageView(with: .userDefaultImage)
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 150 / 2
        image.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didTapUploadImageButton))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    // UILabels
    private(set) lazy var usernameLabel: FNLLabel = {
        let label = FNLLabel(with: "",
                             fontSize: 40,
                             fontWeight: .bold,
                             textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    // UIButtons
    private(set) lazy var sourceCodeButton: FNLButton = {
        let button = FNLButton(title: "GitHub", fontSize: 18,
                               fontWeight: .regular,
                               titleColor: .lightGrayAccent ?? .lightGray)
        button.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var editProfileButton: FNLButton = {
        let button = FNLButton(title: "Edit Profile", fontSize: 14, fontWeight: .regular, titleColor: .white)
        button.configuration = .lightGrayButton()
        button.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var scheduleEventListButton: FNLButton = {
        let button = FNLButton(title: "Scheduler", fontSize: 14, fontWeight: .regular, titleColor: .white)
        button.configuration = .lightGrayButton()
        button.addTarget(self, action: #selector(didTapScheduleEventButton), for: .touchUpInside)
        return button
    }()
    
    // UIStackVies
    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [editProfileButton, scheduleEventListButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 15
        return buttonsStackView
    }()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeViewController()
        retrieveUserImage()
//        removeUserImageFromParse()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Selectors
extension HomeViewController {
    
    // Navigation to UserSettingsViewController
    @objc private func didTapEditProfileButton() {
        
        let userSettingsVC = EditUserProfileViewController()
        userSettingsVC.delegate = self
        navigationController?.pushViewController(userSettingsVC, animated: true)
    }
    
    // navigation controller for WebUIViewController
    @objc private func didTapSourceCodeButton() {
        coordinator?.eventOccurred(with: .sourceCodeButtonTapped)
    }
    
    //    Navigation Button to FirstViewController
    @objc private func didTapLogOutButton() {
        coordinator?.eventOccurred(with: .logOutButtonTapped)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.removeUserImageWhenSignedOut()
            self?.homeViewModel.logOutUser()
        }
    }
    
    @objc private func didTapScheduleEventButton() {
        coordinator?.eventOccurred(with: .goToScheduleListController)
    }
    
    @objc private func didTapUploadImageButton() {
        // Presenting PHPController with configurations to select and upload user image to the app
        AppAlerts.handleUserImageAlert(on: self) { [weak self] _ in
            var configurations = PHPickerConfiguration(photoLibrary: .shared())
            configurations.selectionLimit = 1
            configurations.filter = .images
            
            let photoPickerViewController = PHPickerViewController(configuration: configurations)
            photoPickerViewController.delegate = self
            
            self?.present(photoPickerViewController, animated: true)
        } completionTwo: { [weak self] _ in
            // Deleting uploaded image from FileManager
            self?.imageStorage.removeImage(forKey: .userImage, inStorageType: .fileSystem)
            // Setting the default image as user image
            guard let image = AppImages.userDefaultImage.image else { return }
            self?.userIconImage.image = image
            self?.uploadUserImageToParse(image: image)
        }
    }
}


// MARK: - Helpers
extension HomeViewController {
    
    func configureHomeViewController() {
        configureNavigationBar()
        configureUI()
        retrieveUploadedUserImage()
        loadUserName()
    }
    
    private func configureNavigationBar() {
        // NavigationBar settings
        navigationItem.title = "Home"
        navigationItem.backButtonTitle = "Back"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapLogOutButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func configureUI() {
        
        view.addSubview(screenContainerUIView)
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
        
        view.addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        view.addSubview(scheduleEventListButton)
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
        
        view.addSubview(userIconImage)
        userIconImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(circleBackGroundForUserImage)
            $0.width.height.equalTo(150)
        }
        
        view.addSubview(plusIcon)
        plusIcon.snp.makeConstraints {
            $0.top.equalTo(userIconImage.snp_bottomMargin).inset(12)
            $0.trailing.equalTo(userIconImage.snp_trailingMargin).inset(12)
        }
        
        bottomContainerUIView.addSubview(sourceCodeButton)
        sourceCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(bottomContainerUIView.snp_bottomMargin)
            $0.centerX.equalTo(bottomContainerUIView.snp.centerX)
        }
    }
    
    /// Retrieving User data to load "username" and assign it to usernameLabel
    func loadUserName() {
        usernameLabel.text = homeViewModel.username
    }
    
    /// Uploading User Image to Parse Serve for the current user
    func uploadUserImageToParse(image: UIImage?) {
        guard let image = image else { return }
        guard let imageData =
                image.jpegData(compressionQuality: 0.5) else { return }
        
        homeViewModel.uploadUserImageToParse(imageData: imageData)
    }
    
    func retrieveUserImage() {
        homeViewModel.retrieveUserImageFromParse { [weak self] imageData in
            self?.userIconImage.image = UIImage(data: imageData)
        }
    }
}

// MARK: - PHPicker Delegate for uploading, storing and displaying user image
/// used for adding an image from a photo library to "userImage" on HomePage
extension HomeViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                
                guard let urlImage = image as? UIImage else { return }
                DispatchQueue.global(qos: .userInteractive).async {
                    self?.imageStorage.storeImage(image: urlImage,
                                                  forKey: .userImage,
                                                  withStorageType: .fileSystem)
                    DispatchQueue.main.async { [weak self] in
                        self?.imagedToUpdate = urlImage.withRenderingMode(.alwaysOriginal)
                        // Uploading User Image to Parse server for the current user PFUser object
                        self?.uploadUserImageToParse(image: self?.imagedToUpdate)
                        // Displaying choosen image in the app
                        self?.userIconImage.image = self?.imagedToUpdate
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Retrieve uploaded user image when app is restarted
    private func retrieveUploadedUserImage() {
        DispatchQueue.global(qos: .userInteractive).async {
            if let savedImage = self.imageStorage.retrieveImage(forKey: .userImage,
                                                                inStorageType: .fileSystem) {
                DispatchQueue.main.async { [weak self] in
                    self?.userIconImage.image = savedImage
                }
            }
        }
    }
    
    // Remove the current user image from disk if user logs out
    private func removeUserImageWhenSignedOut() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.imageStorage.removeImage(forKey: .userImage,
                                           inStorageType: .fileSystem)
        }
    }
}

// MARK: - UserSettingsDelegate
extension HomeViewController: EditUserProfileDelegate {
    func didUpdatedUserUsername(withUsername: String) {
        usernameLabel.text = withUsername
    }
}
