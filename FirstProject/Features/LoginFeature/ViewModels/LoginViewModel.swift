//
//  LoginViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 2/10/22.
//

import Parse


class LoginViewModel {
    
    // MARK: - Properties
    var onDidiFinishUserValidation: ((_ state: UserValidationState) -> Void)?
    
    // MARK: - Methods
    private func logInWithUsername(username: String, password: String, completion: @escaping (_ value: Bool) -> Void) {
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
    
    func loginUser(withUsername username: String?, withPassword password: String?) {
        guard let username = username,
              let password = password else { return }
        
        AppDataValidator.checkIfInputIsEmpty(byUsername: username, password: password) { [weak self] in
            self?.onDidiFinishUserValidation?(.empty)
            HapticsManager.shared.vibrateForType(for: .warning)
        }
        
        if !AppDataValidator.validateUserName(username) ||
            !AppDataValidator.validatePassword(password) {
            self.onDidiFinishUserValidation?(.invalid)
        } else {
            if NetworkMonitor.shared.isConnected {
                logInWithUsername(username: username, password: password) { [weak self] value in
                    switch value {
                    case true:
                        do {
                            try UserCaretaker.createUser(withUsername: username, password: password)
                            UserDefaults.standard.set(true, forKey: UserKey.isLoggedIn)
                            HapticsManager.shared.vibrateForType(for: .success)
                            self?.onDidiFinishUserValidation?(.valid)
                        } catch let (error) {
                            print("DEBUG: An error occurred when trying to log in a user the data was not saved to disk \(error) ")
                        }
                    case false:
                        HapticsManager.shared.vibrateForType(for: .error)
                        self?.onDidiFinishUserValidation?(.usernameAlreadyTaken)
                    }
                }
            } else {
                // Stop monitoring if the device has internet connection
                print("DEBUG: The device does not have internet connection.")
                HapticsManager.shared.vibrateForType(for: .error)
                self.onDidiFinishUserValidation?(.noInternetConnection)
                NetworkMonitor.shared.stopMonitoring()
            }
        }
    }
}


