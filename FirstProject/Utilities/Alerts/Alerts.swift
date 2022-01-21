//
//  Alerts.swift
//  FirstProject
//
//  Created by Fenominall on 20.07.2021.
//

import UIKit

enum AlertsMessages {
    case emptyFieldsAlertMessage
    case usernameEmptyAlert
    case passwordEmptyAlert
    case successUpdatedDataMessage
    case userAccountCreatedMessage
    case passwordRequirementsAlertMessage
}



// MARK: UIAlerts for UITextField validations dependent on user interactions
struct AppAlerts {
    
    // Alert for validation to inform the user about the "Incorrect input"
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
    
    /// Showing an error that does not meet user credentials validation politics.
    static func showIncompleteErrorUIAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordRequirementsAlertMessage, preferredStyle: .alert)
    }
    
    /// Alert for validation error if username and password are empty.
    static func emptyFieldsErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: emptyFieldsAlertMessage, preferredStyle: .alert)
    }
    /// Alert for validation error if username is empty.
    static func emptyUsernameErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: usernameEmptyMessage, preferredStyle: .alert)
    }
    /// Alert for validation error if  password is empty.
    static func emptyPasswordErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Error", message: passwordEmptyMessage, preferredStyle: .alert)
    }
    
    // Alert for a successfully created account for a user.
    private static func userAccountCreated(on viewController:
                                       UIViewController,
                                       title: String,
                                       message: String,
                                       preferredStyle: UIAlertController.Style) {
        
        let alertController = UIAlertController(title: title,
                                                       message: message,
                                                       preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Ok",
                                                       style: .default,
                                                       handler: nil))
        viewController.present(alertController, animated: true)
    }
    
    /// Alert for a successfully created account for a user.
    static func showCompleteSuccessUIAlert(on vc: UIViewController) {
        userAccountCreated(on: vc, title: "Success", message: userAccountCreatedMessage, preferredStyle: .alert)
    }
    
    
    // Alert with a completion handler that displaying a success messages when User data is updated.
    private static func dataUpdatedSuccessfully(on viewController: UIViewController,
                                     withTitle title: String,
                                     message: String,
                                     preferredStyle: UIAlertController.Style,
                                     completion: @escaping ((UIAlertAction) -> Void)) {

        let alertController = UIAlertController(title: title,
                                                     message: message,
                                                     preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                     style: .cancel,
                                                     handler: completion))
        viewController.present(alertController, animated: true)
    }
    /// Alert with a completion handler that displaying a success messages when User data is updated.
    static func updatedDataAlertTest(on vc: UIViewController, completion: @escaping ((UIAlertAction) -> Void)) {
        dataUpdatedSuccessfully(on: vc, withTitle: "Success", message: successUpdatedDataMessage, preferredStyle: .alert, completion: completion)
    }
}


// MARK: # AlertsMessages
fileprivate let emptyFieldsAlertMessage = "Password and username fields are required."
fileprivate let usernameEmptyMessage = "Username field is empty."
fileprivate let passwordEmptyMessage = "Password field is empty."
fileprivate let successUpdatedDataMessage = "Your data was successfully updated"
fileprivate let userAccountCreatedMessage = "Your account created your are logged in"
fileprivate let passwordRequirementsAlertMessage = """
                          Username should be at least (min-4, max-20) characters long.
                          Password can be only digits and at least 1 special character, should contain (min-8, max-20) characters long.
                          """



