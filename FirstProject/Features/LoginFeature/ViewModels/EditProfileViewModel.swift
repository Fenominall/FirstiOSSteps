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
            self?.onDidFinishUserValidationState?(.empty)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        AppDataValidator.validateUserInputCredentials(byUsername: username, password: password) { [weak self] in
            self?.onDidFinishUserValidationState?(.invalid)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        if NetworkMonitor.shared.isConnected {
            updateCurrentUser(username: username, password: password) { [weak self] value in
                switch value {
                case true:
                    do {
                        try UserCaretaker.createUser(withUsername: username, password: password)
                        UserDefaults.standard.set(true, forKey: UserKey.isLoggedIn)
                        HapticsManager.shared.vibrateForType(for: .success)
                        self?.onDidFinishUserValidationState?(.valid)

                    } catch let (error) {
                        print("DEBUG: An error occurred when trying to log in a user the data was not saved to disk \(error) ")
                    }
                case false:
                    HapticsManager.shared.vibrateForType(for: .error)
//                    self?.onDidFailLogInUser?()
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
