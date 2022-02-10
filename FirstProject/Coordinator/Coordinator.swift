//
//  Coordinator.swift
//  FirstProject
//
//  Created by Fenominall on 26.08.2021.
//

import Foundation
import UIKit


enum CoordinatorEvents {
    case loginButtonTapped
    case registerButtonTapped
    case goToRegisterController
    case goToLoginController
    case userSettingsTapped
    case logOutButtonTapped
    case sourceCodeButtonTapped
    case finishedViewingSourceCode
    case updateUserDataButtonTapped
    case goToScheduleListController
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var children: [Coordinator]? { get set }

    func eventOccurred(with type: CoordinatorEvents)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
