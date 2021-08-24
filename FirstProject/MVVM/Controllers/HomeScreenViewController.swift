//
//  SecondScreenView.swift
//  FirstProject
//
//  Created by Fenominall on 23.06.2021.
//

import SnapKit
import UIKit


class HomeScreenViewController: UIViewController {

    private var homeSharedView = HomeScreenView()

    override func loadView() {
        super.loadView()
        view = homeSharedView
    }
// Function to add setups for the second view controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeSharedView.updateUserDataButton.addTarget(self, action: #selector(UpdateButtonPressed), for: .touchUpInside)
        homeSharedView.sourceCodeButton.addTarget(self, action: #selector(didTapSourceCodeButton), for: .touchUpInside)
        homeSharedView.logOutUserButton.addTarget(self, action: #selector(LogOutButtonPressed), for: .touchUpInside)
        
    }

// Navigation Controller for updateUserDataBtn "Button" to move to the third screen where the user can update his username and password
    @objc private func UpdateButtonPressed() {
        let rootVC = UserSettingsController()
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    // navigation controller for WebUIViewController
    @objc private func didTapSourceCodeButton() {
        guard let url = URL(string: "https://github.com/Fenominall/FirstiOSSteps") else { return }
        let webViewViewController = SourceCodeWebUIViewController(url: url, title: "GitHub")
        let navVc = UINavigationController(rootViewController: webViewViewController)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true, completion: nil)
    }

    //    Navigation Button to FirstViewController
    @objc private func LogOutButtonPressed() {
        let rootVC = LoginScreenViewController()
        navigationController?.pushViewController(rootVC, animated: true)
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
