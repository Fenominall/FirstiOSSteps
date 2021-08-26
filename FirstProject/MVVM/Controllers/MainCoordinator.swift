import Foundation
import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?

    func eventOccured(with type: Event) {

    }

    func start() {
        var loginViewController: UIViewController & Coordinating = LoginScreenViewController()
        loginViewController.coordinator = self
        navigationController.setViewControllers([vc], animated: true)
    }
}
