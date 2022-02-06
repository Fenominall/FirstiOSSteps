//
//  ActionSheetLauncher.swift
//  FirstProject
//
//  Created by Fenominall on 2/6/22.
//

import UIKit

class ActionSheetLauncher: NSObject {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let reuseIdentifier = "ActionSheetCell"
    private var tableViewWidth: CGFloat?
    // Accessing UIWindow to show tableView on a separate UIWindow in UIViewController
    private var window: UIWindow?
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    
    // MARK: - Lifecycle
    // MARK: - Selectors
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
            self.blackView.alpha = 0
            self.showTableView(false)
        }
    }
    // MARK: - Helpers
    
    func showTableView(_ shouldShow: Bool) {
        guard let window = window else { return }
        guard let width = tableViewWidth else { return }
        // if shouldShow is true table view be shown with the predefined width or it will be hidden
        let xCoordinate = shouldShow ? window.frame.width - width : window.frame.width
        tableView.frame.origin.x = xCoordinate
    }
    
    
    
    
}
