import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?

    func eventOccured(with type: Event) {
        switch type {
            case .buttonTapped:
                let homeVC: UIViewController & Coordinating = HomeScreenViewController()
                homeVC.coordinator = self
                navigationController?.pushViewController(homeVC, animated: true)
        }
    }

    func start() {
        var loginViewController: UIViewController & Coordinating = LoginScreenViewController()
        loginViewController.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
}
