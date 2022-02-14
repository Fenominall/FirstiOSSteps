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
    func uploadUserImageToParse(imageData: Data) {
        // Converting an image into Data with the filename - avatar.jpg
        let imageFile = PFFileObject(name: "avatar.jpg", data: imageData)
        // Getting the current user Object
        let user  = PFUser.current()
        // Adding new property "avatar" FileObject to the current user object
        user?["avatar"] = imageFile
        
        user?.saveInBackground(block: { (success: Bool, error: Error?) in
            if success {
                print("DEBUG: WE DID IT THE IMAGE WAS UPLOADED TO PARSE")
            } else {
                print("DEBUG: WE FAILED THE IMAGE WAS NOT UPLOADED TO PARSE")
            }
        })
    }
    
    
    func retrieveUserImageFromParse(completion: @escaping (Data) -> Void?) {
        guard let currentUser = PFUser.current() else { return }
        if let currentUserImage = currentUser["avatar"] as? PFFileObject {
            currentUserImage.getDataInBackground { (result, error) in
                if result != nil && error == nil {
                    guard let result = result else { return }
                    completion(result)
                } else {
                    print("DEBUG: AN ERROR OCCURRED WHEN TRYING TO DOWNLOAD A USER IMAGE FROM PARSE \(String(describing: error))")
                }
            }
        }
    }
    
//    func removeUserImageFromParse() {
//        guard let currentUser = PFUser.current() else { return }
//
//        let query = PFQuery(className: "User")
//        query.getObjectInBackground(withId: currentUser.objectId ?? "") { (object: AnyObject?, error: Error?) in
//            if object != nil && error == nil {
//                print("DEBUG: WE GOT IT \(String(describing: object?.objectId))")
//            } else {
//                print("Sorry")
//            }
//        }
//    }
    
    
    // LogOut the current user from the session on Parse Server
    func logOutUser() {
        // Setting the flag that a user logged out and next time when he launches an app, he will see LoginScreen
        UserDefaults.standard.set(false, forKey: UserKey.isLoggedIn)
        PFUser.logOutInBackground()
    }
}

