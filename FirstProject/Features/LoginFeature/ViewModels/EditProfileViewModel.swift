
//
//  EditProfileViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 2/11/22.
//

import Parse

class EditProfileViewModel {
    
    // MARK: - Properties
    var username: String?
    var password: String?
    
    var onDidFinishUserValidationState: ((_ state: UserValidationState) -> Void)?
    var onDidFailUpdateUser: (() -> Void)?
    
    // MARK: - Lifecycle
    // Initializer that helps to retrieve UserData with the help of UserCaretaker class
    init() {
        do {
            let user = try UserCaretaker.loadUserData()
            self.username = user.username
            self.password = user.password
        } catch (let error) {
            print("DEBUG: Error loading user data \(error)")
        }
    }
    
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
    
    func updateUser(withUsername username: String?, withPassword password: String?) {
        guard let username = username,
              let password = password else { return }
        
        AppDataValidator.checkIfInputIsEmpty(byUsername: username, password: password) { [weak self] in
            HapticsManager.shared.vibrateForType(for: .warning)
            self?.onDidFinishUserValidationState?(.empty)
        }
        
        if !AppDataValidator.validateUserName(username) ||
            !AppDataValidator.validatePassword(password) {
                HapticsManager.shared.vibrateForType(for: .error)
                onDidFinishUserValidationState?(.invalid)
        } else {
            if NetworkMonitor.shared.isConnected {
                updateCurrentUser(username: username, password: password) { [weak self] value in
                    switch value {
                    case true:
                        do {
                            try UserCaretaker.createUser(withUsername: username, password: password)
                            self?.onDidFinishUserValidationState?(.valid)
                            print("DEBUG: THE USER DATA WAS UPDATED WITH USERNAME '\(username.uppercased())' AND PASSWORD \(password.uppercased()) ")
                        } catch let (error) {
                            print("DEBUG: An error occurred when trying to log in a user the data was not saved to disk \(error) ")
                        }
                    case false:
                        HapticsManager.shared.vibrateForType(for: .error)
                        self?.onDidFailUpdateUser?()
                    }
                }
            } else {
                // Stop monitoring if the device has internet connection
                print("DEBUG: The device does not have internet connection.")
                HapticsManager.shared.vibrateForType(for: .error)
                self.onDidFinishUserValidationState?(.noInternetConnection)
                NetworkMonitor.shared.stopMonitoring()
            }
        }
    }
}
