//
//  Alerts.swift
//  FirstProject
//
//  Created by Fenominall on 20.07.2021.
//

import UIKit

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
        errorUIAlert(on: vc, with: "", message: passwordRequirementsAlertMessage, preferredStyle: .alert)
    }
    
    /// Alert for validation error if username and password are empty.
    static func emptyFieldsErrorAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "", message: emptyFieldsAlertMessage, preferredStyle: .alert)
    }
    
    static func usernameIsAlreadyTakenAlert(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "", message: usernamesISAlreadyTakenErrorMessage, preferredStyle: .alert)
    }
    
    
    static func incorrectCredentials(on vc: UIViewController) {
        errorUIAlert(on: vc, with: "Incorrect Credentials", message: incorrectCredentialsMessage, preferredStyle: .alert)
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
        alertController.addAction(UIAlertAction(title: "OK",
                                                       style: .default,
                                                       handler: nil))
        viewController.present(alertController, animated: true)
    }
    
    /// Alert for a successfully created account for a user.
    static func showCompleteSuccessUIAlert(on vc: UIViewController) {
        userAccountCreated(on: vc, title: "Success", message: userAccountCreatedMessage, preferredStyle: .alert)
    }
    
    
    static func noInternetConnectionAlert(on vc: UIViewController) {
        userAccountCreated(on: vc, title: "Error", message: noInternetConnectionMessage, preferredStyle: .alert)
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
    static func updatedDataAlert(on vc: UIViewController, completion: @escaping ((UIAlertAction) -> Void)) {
        dataUpdatedSuccessfully(on: vc, withTitle: "Success", message: successUpdatedDataMessage, preferredStyle: .alert, completion: completion)
    }
    
    // Alert to manipulate with user profileImage image
    // selecting an image for a user
    // setting user image
    // deleting user image
    private static func handleUserImageAlertController(on viewController: UIViewController,
                                        withTitle title: String,
                                        preferredStyle: UIAlertController.Style,
                                        completionOne: @escaping ((UIAlertAction) -> Void),
                                        completionTwo: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))
        alertController.addAction(UIAlertAction(title: "Choose from library",
                                                style: .default,
                                                handler: completionOne))
        alertController.addAction(UIAlertAction(title: "Remove current photo",
                                                style: .destructive,
                                                handler: completionTwo))
        viewController.present(alertController, animated: true)
    }
    
    static func handleUserImageAlert(on vc: UIViewController,
                                     completionOne: @escaping ((UIAlertAction) -> Void),
                                     completionTwo: @escaping ((UIAlertAction) -> Void)) {
        handleUserImageAlertController(on: vc,
                                       withTitle: "Change profile photo",
                                       preferredStyle: .actionSheet,
                                       completionOne: completionOne,
                                       completionTwo: completionTwo)
    }
}


// MARK: # AlertsMessages
fileprivate let emptyFieldsAlertMessage = "Password and username fields are required."
fileprivate let usernamesISAlreadyTakenErrorMessage = "The username you entered is already taken."
fileprivate let successUpdatedDataMessage = "Your data was successfully updated."
fileprivate let userAccountCreatedMessage = "Your account created your are logged in."
fileprivate let incorrectCredentialsMessage = "The credentials you entered don`t appear to belong to an account. Please check your credentials and try again."
fileprivate let passwordRequirementsAlertMessage = """
                          Username should be at least (min-4, max-20) characters long.
                          Password can be only digits and at least 1 special character, should contain (min-8, max-20) characters long.
                          """
fileprivate let noInternetConnectionMessage = "Please check your internet connection and try again later."



