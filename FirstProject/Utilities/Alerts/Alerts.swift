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
    private static func errorUIAlert(on viewController: UIViewController,
                                     with title: String,
                                     message: String,
                                     preferredStyle: UIAlertController.Style) {
        
        let errorAlertController = UIAlertController(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "Ok",
                                                     style: .destructive,
                                                     handler: nil))
        viewController.present(errorAlertController, animated: true)
    }
    
    static func showIncompleteErrorUIAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordRequirementsAlertMessage, preferredStyle: .alert)
    }
    
    /// Alert for validation if username and password are empty
    static func emptyFieldsErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: emptyFieldsAlertMessage, preferredStyle: .alert)
    }
    
    static func emptyUsernameErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: usernameEmptyAlert, preferredStyle: .alert)
    }
    
    static func emptyPasswordErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordEmptyAlert, preferredStyle: .alert)
    }
    
    /// Alert for validation to inform the user "Success"
    /// - Parameters:
    ///   - title: Ok
    ///   - message: let emptyFieldsAlertMessage
    ///   - preferredStyle: .alert
    private static func successUIAlert(on viewController:
                                       UIViewController,
                                       title: String,
                                       message: String,
                                       preferredStyle: UIAlertController.Style) {
        
        let successAlertController = UIAlertController(title: title,
                                                       message: message,
                                                       preferredStyle: .alert)
        
        successAlertController.addAction(UIAlertAction(title: "Ok",
                                                       style: .default,
                                                       handler: nil))
        viewController.present(successAlertController, animated: true)
    }
    
    static func showCompleteSuccessUIAlert(on vc: UIViewController) {
        successUIAlert(on: vc, title: "Success", message: successAlertMessage, preferredStyle: .alert)
    }
    
    
    // MARK: - Image Picker Alert
    private static func updatedDataAlert(on viewController: UIViewController,
                                     withTitle title: String,
                                     message: String,
                                     preferredStyle: UIAlertController.Style,
                                     completion: @escaping ((UIAlertAction) -> Void)) {

        let errorAlertController = UIAlertController(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        errorAlertController.addAction(UIAlertAction(title: "OK",
                                                     style: .cancel,
                                                     handler: completion))
        viewController.present(errorAlertController, animated: true)
    }
    
    static func updatedDataAlertTest(on vc: UIViewController, completion: @escaping ((UIAlertAction) -> Void)) {
        updatedDataAlert(on: vc, withTitle: "Success", message: successUpdatedDataMessage, preferredStyle: .alert, completion: completion)
    }
}


// MARK: # AlertsMessages
fileprivate let emptyFieldsAlertMessage = "Password and username fields are required."
fileprivate let usernameEmptyAlert = "Username field is empty."
fileprivate let passwordEmptyAlert = "Password field is empty."
fileprivate let successUpdatedDataMessage = "Your data was successfully updated"
fileprivate let successAlertMessage = "Your account created your are logged in"
fileprivate let passwordRequirementsAlertMessage = """
                          Username should be at least (min-4, max-20) characters long.
                          Password can be only digits and at least 1 special character, should contain (min-8, max-20) characters long.
                          """
