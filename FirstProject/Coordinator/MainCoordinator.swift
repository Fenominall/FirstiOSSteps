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
    
    
    func eventOccurred(with type: CoordinatorEvents) {
        
        switch type {
            
        case .loginButtonTapped:
            var homeVC: UIViewController & Coordinating = HomeViewController()
            homeVC.coordinator = self
            navigationController?.pushViewController(homeVC, animated: true)
            
        case .userSettingsTapped:
            var userSettingsVC: UIViewController & Coordinating = UserSettingsViewController()
            userSettingsVC.coordinator = self
            navigationController?.pushViewController(userSettingsVC, animated: true)
            
        case .logOutButtonTapped:
            var loginsSreenViewController: UIViewController & Coordinating = LoginViewController()
            loginsSreenViewController.coordinator = self
            // If UserKey.isLoggedIn ==  false, then LoginViewController will be shown,
            // if (true) HomeViewController will be shown
            UserDefaults.standard.set(false, forKey: UserKey.isLoggedIn)
            navigationController?.pushViewController(loginsSreenViewController, animated: true)
            
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
        case .createEventButtonTapped:
            print("1")
            //            var createEventController: UIViewController & Coordinating = CreateEventController()
            //            createEventController.coordinator = self
            //            navigationController?.present(createEventController, animated: true, completion: nil)
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
