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

protocol HomeViewControllerDelegate: AnyObject {
    func handleMenuToggle()
}

class HomeViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var homeSharedView = HomeView()
    private var imageStorage = ImageStorage()
    private var homeViewModel = HomeViewModel()
    
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = homeSharedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureActions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Selectors
extension HomeViewController {
    
    // Navigation to UserSettingsViewController
    @objc private func didTapUpdateButton() {
        let userSettingsVC = UserSettingsViewController()
        userSettingsVC.delegate = self
        navigationController?.pushViewController(userSettingsVC, animated: true)
    }
    
    // navigation controller for WebUIViewController
    @objc private func didTapSourceCodeButton() {
        coordinator?.eventOccurred(with: .sourceCodeButtonTapped)
    }
    
    //    Navigation Button to FirstViewController
    @objc private func didTapLogOutButton() {
        delegate?.handleMenuToggle()
        //        homeViewModel.logOutUser()
        //        removeUserImageWhenSignedOut()
        //        coordinator?.eventOccurred(with: .logOutButtonTapped)
    }
    
    @objc private func logOutTest() {
        homeViewModel.logOutUser()
        removeUserImageWhenSignedOut()
        coordinator?.eventOccurred(with: .logOutButtonTapped)
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
            self?.homeSharedView.uploadImageButton.setImage(AppImages.userImage, for: .normal)
        }
    }
}


// MARK: - Helpers
extension HomeViewController {
    
    private func configureUI() {
        // NavigationBar settings
        navigationItem.title = "Home"
        navigationItem.backButtonTitle = "Back"
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(didTapLogOutButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOutTest))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func configureActions() {
        homeSharedView.editProfileButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        homeSharedView.sourceCodeButton.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        homeSharedView.uploadImageButton.addTarget(self, action: #selector(didTapUploadImageButton), for: .touchUpInside)
        homeSharedView.scheduleEventListButton.addTarget(self, action: #selector(didTapScheduleEventButton), for: .touchUpInside)
        
        retrieveUploadedUserImage()
        loadUserName()
    }
    
    /// Retrieving User data to load "username" and assign it to usernameLabel
    func loadUserName() {
        homeSharedView.usernameLabel.text = homeViewModel.username
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
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        // Display chosen image
                        self.homeSharedView.uploadImageButton.setImage(urlImage.withRenderingMode(.alwaysOriginal),
                                                                       for: .normal)
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
                DispatchQueue.main.async {
                    self.homeSharedView.uploadImageButton.setImage(savedImage.withRenderingMode(.alwaysOriginal),
                                                                   for: .normal)
                }
            }
        }
    }
    
    // Remove the current user image from disk if user logs out
    private func removeUserImageWhenSignedOut() {
        DispatchQueue.global(qos: .background).async {
            self.imageStorage.removeImage(forKey: .userImage,
                                          inStorageType: .fileSystem)
        }
    }
}

// MARK: - UserSettingsDelegate
extension HomeViewController: UserSettingsDelegate {
    func didUpdatedUserUsername(withUsername: String) {
        homeSharedView.usernameLabel.text = withUsername
    }
}
