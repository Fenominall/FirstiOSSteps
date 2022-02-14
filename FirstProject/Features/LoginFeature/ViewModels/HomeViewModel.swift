//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation
import Parse

final class HomeViewModel {
    
    // MARK: - Properties
    /// Variable which stores User username
    var username: String?
        
    // MARK: - Lifecycle
    // Initializer that helps to retrieve UserData with the help of UserCaretaker class
    init() {
        do {
            let user = try UserCaretaker.loadUserData()
            self.username = user.username
        } catch (let error) {
            print("DEBUG: Error loading user data \(error)")
        }
    }
    
    // MARK: - Helpers
    
    /// Uploading User Image to Parse Serve for the current user
    func uploadUserImageToServer(imageData: Data) {
        ImageService.shared.uploadUserImageToParse(imageData: imageData)
    }
    
    func retrieveUserImageFromServer(completion: @escaping (Data) -> Void?) {
        ImageService.shared.retrieveUserImageFromParse { completion($0) }
    }

    // LogOut the current user from the session on Parse Server
    func logOutUser() {
        // Setting the flag that a user logged out and next time when he launches an app, he will see LoginScreen
        UserDefaults.standard.set(false, forKey: UserKey.isLoggedIn)
        UserService.shared.logOutUser()
    }
}

