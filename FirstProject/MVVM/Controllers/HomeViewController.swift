//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import SnapKit
import UIKit


class HomeViewController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    private var homeSharedView = HomeView()
    private var homeViewModel = HomeViewModel()
    
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = homeSharedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargetsForButtons()
        loadUserPhotoWithDispatch()
    }
}

// MARK: - Handling Navigation
extension HomeViewController {
    
    private func setupTargetsForButtons() {
        homeSharedView.editProfileButton.addTarget(self, action: #selector(UpdateButtonPressed), for: .touchUpInside)
        homeSharedView.sourceCodeButton.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        homeSharedView.logOutUserButton.addTarget(self, action: #selector(LogOutButtonPressed), for: .touchUpInside)
    }
    
    // Navigation to UserSettingsViewController
    @objc private func UpdateButtonPressed() {
        coordinator?.eventOccurred(with: .userSettingsTapped)
    }
    
    // navigation controller for WebUIViewController
    @objc private func didTapSourceCodeButton() {
        coordinator?.eventOccurred(with: .sourceCodeButtonTapped)
    }
    
    //    Navigation Button to FirstViewController
    @objc private func LogOutButtonPressed() {
        coordinator?.eventOccurred(with: .logOutButtonTapped)
    }
}

// MARK: - Extension to disable NavigationBar
extension HomeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Fetching user image from the internet by using GCD with workItem
extension HomeViewController {
    
    func loadUserPhotoWithDispatch() {
        
        var data: Data?
        
        guard let testUserImageURL = URL(string: "https://brkng.news/wp-content/uploads/2020/07/pantera1-640x640.jpg") else {
            return
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        let userImageWorkItem = DispatchWorkItem(qos: .userInitiated) {
            data = try? Data(contentsOf: testUserImageURL)
            print("Image is here")
        }
        
        queue.async(execute: userImageWorkItem)
        
        userImageWorkItem.notify(queue: DispatchQueue.main) { [weak self] in
            if let imageData = data {
                self?.homeSharedView.userUImageView.image = UIImage(data: imageData)
            }
        }
    }
}
