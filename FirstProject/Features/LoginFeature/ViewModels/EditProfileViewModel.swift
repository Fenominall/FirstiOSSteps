//
//  EditProfileViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 2/11/22.
//

import Parse

class EditProfileViewModel {
    
    // MARK: - Properties
    var onDidFinishUserValidationState: ((_ state: UserValidationState) -> Void)?
    
    // MARK: - Actions
    private func updateCurrentUser(username: String, password: String, completion: @escaping (_ value: Bool) -> Void) {
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
                print("DEBUG: An error occured when trying to update user info \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    
    
}
