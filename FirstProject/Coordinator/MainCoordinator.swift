//
//  MainCoordinator.swift
//  FirstProject
//
//  Created by Fenominall on 26.08.2021.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func eventOccurred(with type: CoordinatorEvents) {
        
        switch type {
            
        case .loginButtonTapped:
            var homeVC: UIViewController & Coordinating = HomeViewController()
            homeVC.coordinator = self
            navigationController?.pushViewController(homeVC, animated: true)
            
        case .goToRegisterController:
            var registerVC: UIViewController & Coordinating = RegistrationViewController()
            registerVC.coordinator = self
            navigationController?.pushViewController(registerVC, animated: true)
            
        case .goToLoginController:
            navigationController?.popViewController(animated: true)
            
        case .userSettingsTapped:
            var userSettingsVC: UIViewController & Coordinating = UserSettingsViewController()
            userSettingsVC.coordinator = self
            navigationController?.pushViewController(userSettingsVC, animated: true)
            
        case .logOutButtonTapped:
            // Setting the flag that a user logged out and next time when he launches an app, he will see LoginScreen
            UserDefaults.standard.set(false, forKey: UserKey.isLoggedIn)
            var loginViewController: UIViewController & Coordinating = LoginViewController()
            loginViewController.coordinator = self
            navigationController?.pushViewController(loginViewController, animated: true)
            
            
        case .sourceCodeButtonTapped:
            guard let url = URL(string: "https://github.com/Fenominall/FirstiOSSteps") else { return }
            var webViewViewController: UIViewController & Coordinating = SourceCodeWebUIViewController(url: url, title: "GitHub")
            webViewViewController.coordinator = self
            navigationController?.pushViewController(webViewViewController, animated: true)
            
        case .finishedViewingSourceCode:
            navigationController?.popViewController(animated: true)
        case .updateUserDataButtonTapped:
            navigationController?.popViewController(animated: true)
        case .goToScheduleListController:
            var scheduleListController: UIViewController & Coordinating = ScheduleListController()
            scheduleListController.coordinator = self
            navigationController?.pushViewController(scheduleListController, animated: true)
    }
}
    
    func start() {
        let userLoginStatus = UserDefaults.standard.bool(forKey: UserKey.isLoggedIn)
        
        if (userLoginStatus == false) {
            var loginViewController: UIViewController & Coordinating = LoginViewController()
            loginViewController.coordinator = self
            navigationController?.setViewControllers([loginViewController], animated: false)
        } else {
            var homeViewController: UIViewController & Coordinating = HomeViewController()
            homeViewController.coordinator = self
            navigationController?.setViewControllers([homeViewController], animated: false)
            
        }
    }
}
