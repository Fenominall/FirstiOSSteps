//
//  MainCoordinator.swift
//  FirstProject
//
//  Created by Fenominall on 26.08.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?
    var children: [Coordinator]? = nil

    
    func eventOccured(with type: Event) {
        switch type {
            case .loginButtonTapped:
                var homeVC: UIViewController & Coordinating = HomeScreenViewController()
                homeVC.coordinator = self
                homeVC.modalPresentationStyle = .fullScreen
                navigationController?.pushViewController(homeVC, animated: true)
        //                navigationController?.pushViewController(homeVC, animated: true)
            case .userSettingsTapped:
                var userSettingsVC: UIViewController & Coordinating = UserSettingsController()
                userSettingsVC.coordinator = self
                navigationController?.pushViewController(userSettingsVC, animated: true)
        case .logOuteButtonTapped:
            var loginsSreenViewController: UIViewController & Coordinating = LoginScreenViewController()
            loginsSreenViewController.coordinator = self
            navigationController?.pushViewController(loginsSreenViewController, animated: true)
            
//        case .updateButtonTapped:
//
        }
    }

    func start() {
        var loginViewController: UIViewController & Coordinating = LoginScreenViewController()
        loginViewController.coordinator = self
        navigationController?.setViewControllers([loginViewController], animated: false)
    }
}
