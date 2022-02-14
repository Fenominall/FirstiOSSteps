//
//  UserService.swift
//  FirstProject
//
//  Created by Fenominall on 2/14/22.
//

import Parse

public final class UserService {
    
    // MARK: - Properties
    public static let shared = UserService()
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Helpers
    
    /// Sign Up new User
    public func signUpUser(with username: String,
                                  password: String,
                                  completion: @escaping(_ value: Bool) -> Void) {
        // Creating new instance of a PF user on Parse Server
        let createPFUser = PFUser()
        // updating PFUser with the users input in registration field
        createPFUser.username = username
        createPFUser.password = password
        // creating new user asynchronously and saving the user data to disk
        createPFUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                completion(true)
            } else {
                completion(false)
                print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO SIGN UP A USER \(String(describing: error?.localizedDescription)) ")
            }
        }
    }
    
    /// Log In User to the App and create new active session for logged in user
    public func logInWithUsername(username: String,
                                  password: String,
                                  completion: @escaping (_ value: Bool) -> Void) {
        PFUser.logInWithUsername(inBackground: username,
                                 password: password) {
            (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                completion(true)
            } else {
                completion(false)
                print("DEBUG: AN ERROR OCCURRED WWHEN TRYING TO LOG IN THE USER \(error?.localizedDescription ?? "") ")
            }
        }
    }
    
    /// Update current user profile on the Parse Server
    public func updateCurrentUser(username: String,
                                  password: String,
                                  completion: @escaping (_ value: Bool) -> Void) {
        // Getting the current logged in user on Parse Server
        let currentPFUser = PFUser.current()
        // Updating currentPFUser with the inputed data that updated the User model in the app
        currentPFUser?.username = username
        currentPFUser?.password = password
        // saving changes of currentPFUser to Parse Server
        currentPFUser?.saveInBackground(block: { (success: Bool, error: Error?) in
            if success {
                completion(true)
            } else {
                completion(false)
                print("DEBUG: An error occurred when trying to update user info \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    /// Log Out the current user from Parse Session
    public func logOutUser() {
        PFUser.logOutInBackground()
    }
    
}
