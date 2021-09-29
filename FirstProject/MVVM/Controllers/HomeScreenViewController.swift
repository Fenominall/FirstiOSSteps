//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import SnapKit
import UIKit


class HomeScreenViewController: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    private var homeSharedView = HomeScreenView()
    
    override func loadView() {
        super.loadView()
        view = homeSharedView
    }
    
    // Lifecycle     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeSharedView.updateUserDataButton.addTarget(self, action: #selector(UpdateButtonPressed), for: .touchUpInside)
        homeSharedView.sourceCodeButton.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        homeSharedView.logOutUserButton.addTarget(self, action: #selector(LogOutButtonPressed), for: .touchUpInside)
        
        loadUserPhotoWithDispatch()
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

// MARK: Extension to disable NavigationBar
extension HomeScreenViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: Fetching user image from the internet by using GCD with workItem
extension HomeScreenViewController {
    
    func loadUserPhotoWithDispatch() {
        
        var data: Data?
        
        guard let testUserImageURL = URL(string: "https://instagram.fdnk3-2.fna.fbcdn.net/v/t51.2885-19/s150x150/233692174_1222350424870711_9119269687752441282_n.jpg?_nc_ht=instagram.fdnk3-2.fna.fbcdn.net&_nc_ohc=EOR8RIu6bpwAX-9DVjM&edm=ABfd0MgBAAAA&ccb=7-4&oh=2c1d889fd527b95eb3cce66ba69cb560&oe=615837AF&_nc_sid=7bff83.jpg") else {
            return
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        let userImageWorkItem = DispatchWorkItem(qos: .userInitiated) {
            data = try? Data(contentsOf: testUserImageURL)
            print("Image is here")
        }
        
        queue.async(execute: userImageWorkItem)
        
        userImageWorkItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.homeSharedView.userUImageView.image = UIImage(data: imageData)
            }
        }
    }
}
