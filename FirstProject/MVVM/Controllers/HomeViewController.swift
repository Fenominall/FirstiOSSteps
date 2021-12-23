//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//
import Photos
import PhotosUI
import SnapKit
import UIKit


class HomeViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var homeSharedView = HomeView()
    private var imageStorage = ImageStorage()
    private var homeViewModel = HomeViewModel()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = homeSharedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargetsForButtons()
        retrieveUploadedUserImage()
        navigationController?.navigationBar.barStyle = .black
//        loadUserName()
        
        homeViewModel.userName.bind { [unowned self] in
            self.homeSharedView.usernameLabel.text = $0
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
//    private func loadUserName() {
//        do {
//            let userUsername = try UserCaretaker.loadUserData()
//            print(userUsername.username + "Test")
//            homeSharedView.usernameLabel.text = userUsername.username
//        } catch {
//            print("error loading events: \(error)")
//        }
//
//    }
    
    
}

// MARK: - Selectors
extension HomeViewController {
    
    // Navigation to UserSettingsViewController
    @objc private func didTapUpdateButton() {
        coordinator?.eventOccurred(with: .userSettingsTapped)
    }
    
    // navigation controller for WebUIViewController
    @objc private func didTapSourceCodeButton() {
        coordinator?.eventOccurred(with: .sourceCodeButtonTapped)
    }

    //    Navigation Button to FirstViewController
    @objc private func didTapLogOutButton() {
        coordinator?.eventOccurred(with: .logOutButtonTapped)
    }
    
    @objc private func didTapScheduleEventButton() {
        coordinator?.eventOccurred(with: .goToScheduleListController)
    }
}


// MARK: - Helpers
extension HomeViewController {
    
    private func setupTargetsForButtons() {
        homeSharedView.editProfileButton.addTarget(self, action: #selector(didTapUpdateButton), for: .touchUpInside)
        homeSharedView.sourceCodeButton.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        homeSharedView.uploadImageButton.addTarget(self, action: #selector(didTapUploadImageButton), for: .touchUpInside)
        homeSharedView.scheduleEventListButton.addTarget(self, action: #selector(didTapScheduleEventButton), for: .touchUpInside)

        
        // Navigation settings
        navigationItem.title = "Home"
        navigationItem.backButtonTitle = ""
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(didTapLogOutButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func didTapUploadImageButton() {
        let actionSheet = UIAlertController(title: nil,
                                            message: "Change profile photo",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Choose from library",
                                            style: .default,
                                            handler: { [weak self] _ in
            var configurations = PHPickerConfiguration(photoLibrary: .shared())
            configurations.selectionLimit = 1
            configurations.filter = .images
            
            let photoPickerViewController = PHPickerViewController(configuration: configurations)
            photoPickerViewController.delegate = self
            
            self?.present(photoPickerViewController, animated: true)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Remove current photo",
                                            style: .destructive,
                                            handler: { [weak self] _ in
            self?.imageStorage.removeImage(forKey: .userImage, inStorageType: .fileSystem)
            self?.homeSharedView.userUImageView.image = AppImages.userImage
        }))
        
        present(actionSheet, animated: true)
    }
}

// MARK: - PHPicker Delegate for uploading, storing and displaying user image
/// used for adding an image from a photo library to "userImage" on HomePage
extension HomeViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {

            itemProvider.loadObject(ofClass: UIImage.self)
            { [weak self] image, error in
                guard let urlImage = image as? UIImage else { return }
                DispatchQueue.global(qos: .userInteractive).async {
                    self?.imageStorage.storeImage(image: urlImage,
                                                  forKey: .userImage,
                                                  withStorageType: .fileSystem)
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        // Display chosen image
                        self.homeSharedView.userUImageView.image = urlImage
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
                    self.homeSharedView.userUImageView.image = savedImage
                }
            }
        }
    }
    
}
