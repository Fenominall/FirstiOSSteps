//
//  ContainerController.swift
//  FirstProject
//
//  Created by Fenominall on 2/2/22.
//

import UIKit

class ContainerController: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    var menuController: MenuController!
    var centerController: UIViewController!
    // Bool to define if menu controller should be expanded or not
    var isExpanded = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        // Show status bar if isExpanded is true
        return isExpanded
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    func configureHomeController() {
        let homeController = HomeViewController()
        homeController.delegate = self
        // setting the homeController as a rootViewController in the ContainerController
        centerController = UINavigationController(rootViewController: homeController)
        // adding controller as a subView for ContainerController
        view.addSubview(centerController.view)
        // adding child to ContainerController
        addChild(centerController)
        // HomeVC will be moved to ContainerController
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        // checking if menuController is not nil if its nil assigning to it MenuController
        if menuController == nil {
            //
            menuController = MenuController()
            // inserting menuController view as a subView at a first position in a container
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePenalOptions(shouldExpand: Bool) {
        if shouldExpand {
            //show menu
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseInOut,
                           animations: {
                self.centerController.view.frame.origin.x =
                self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            // hide menu
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseInOut,
                           animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
        animateStatusBar()
    }
    
    // Animating status bar when moving the container
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}

// MARK: - HomeViewControllerDelegate
extension ContainerController: HomeViewControllerDelegate {
    func handleMenuToggle() {
        // check if isExpanded not false
        if !isExpanded {
            configureMenuController()
        }
        // every time the function is called isExpanded value will be reversed to the opposite value
        isExpanded = !isExpanded
        animatePenalOptions(shouldExpand: isExpanded)
        print("DEBUG: It is working")
    }
}
