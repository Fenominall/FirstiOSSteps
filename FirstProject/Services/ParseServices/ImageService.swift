//
//  ImageService.swift
//  FirstProject
//
//  Created by Fenominall on 2/14/22.
//

import Foundation
import Parse

public final class ImageService {
    
    // MARK: - Lifecycle
    static let shared = ImageService()
    
    // MARK: - Lifecycle
    private init() {}
    
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
    
    
    
    
    // ### Testing function
    func removeUserImageFromParse() {
        guard let currentUser = PFUser.current() else { return }
        guard let objectID = currentUser.objectId else { return }
        
        let query = PFUser.query()
        query?.getObjectInBackground(withId: objectID, block: { (object: AnyObject?, error: Error?) -> Void in
            if object != nil && error == nil {
                if let avatar = object?["avatar"] as? PFObject {
                    avatar.deleteInBackground { (success, error) in
                        if success {
                            print("The File was deleted")
                        } else {
                            print("THE FILE WAS NOT DELETED")
                        }
                    }
                }
                print("DEBUG: WE GOT IT \(String(describing: object?.objectId))")
            } else {
                print("Sorry")
            }
        })
    }
    // ###
    
}
