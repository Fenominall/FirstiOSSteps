//
//  Alerts.swift
//  FirstProject
//
//  Created by Fenominall on 20.07.2021.
//

import Foundation
import UIKit


//    MARK: UIAlerts for UITextField validations dependent on user interactions
struct AppAlerts {
    
    /// Alert for validation to inform the user about the "Incorrect input"
    /// - Parameters:
    ///   - title: Dismiss
    ///   - message: let passwordRequirmentsAlertMessage
    ///   - preferedStyle: .alert
    private static func errorUIAlert(on viewController: UIViewController, with title: String, message: String, preferedStyle: UIAlertController.Style) {
        let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController.present(errorAlertController, animated: true)
    }
    
    static func showIncompleteErrorUIAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordRequirmentsAlertMessage, preferedStyle: .alert)
    }
    
    /// Alert for validation if username and password are empty
    static func emptyFieldsErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: emptyFieldsAlertMessage, preferedStyle: .alert)
    }
    
    static func emptyUsernameErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: usernameEmptyAlert, preferedStyle: .alert)
    }
    
    static func emptyPasswordErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordEmptyAlert, preferedStyle: .alert)
    }
    
    /// Alert for validation to inform the user "Success"
    /// - Parameters:
    ///   - title: Ok
    ///   - message: let emptyFieldsAlertMessage
    ///   - preferedStyle: .alert
    private static func successUIAlert(on viewController: UIViewController, title: String, message: String, preferedStyle: UIAlertController.Style) {
        let successAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(successAlertController, animated: true)
    }

    static func showIncompleteSuccessUIAlert(on vc: UIViewController) {
        successUIAlert(on: vc, title: "Success", message: successAlertMessage, preferedStyle: .alert)
    }
    
    /// Alert after user credentials were updated
    /// - Parameters:
    ///   - title: Ok
    ///   - message: let successUpdatedDataMessage
    ///   - preferedStyle: .alert
    private static func updatedDataUIAler(on viewController: UIViewController, title: String, message: String, preferedStyle: UIAlertController.Style) {
        let successUpdatedDataUIAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "OK", style: .default) { (_) -> () in
            
            let secondVC = SecondViewController()
            let navController = UINavigationController(rootViewController: secondVC)
            navController.modalPresentationStyle = .fullScreen
            viewController.present(navController, animated: true)
        }

        successUpdatedDataUIAlert.addAction(updateAction)
        viewController.present(successUpdatedDataUIAlert, animated: true, completion: nil)
    }
    
    static func showIncompleteUpdatedDataAlert(on vc: UIViewController) {
        updatedDataUIAler(on: vc, title: "Success", message: successUpdatedDataMessage, preferedStyle: .alert)
    }
}



// MARK: # AlertsMessages
fileprivate let emptyFieldsAlertMessage = "Password and username fields are required."
fileprivate let usernameEmptyAlert = "Username field is empty."
fileprivate let passwordEmptyAlert = "Password field is empty."
fileprivate let successUpdatedDataMessage = "Your data was successfully updated"
fileprivate let successAlertMessage = "Your account created your are logged in"
fileprivate let passwordRequirmentsAlertMessage = """
                          Username should be at least (min-4, max-20) charachters long.
                          Password can be only digits and at least 1 special charechter, should contain (min-8, max-20) charachters long.
                          """
