//
//  MyExtensions.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

import Foundation
import UIKit


// MARK: Extension to handle Dismiss/Hide The KeyBoard
extension LoginViewController: UITextFieldDelegate {
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

}

//MARK: Extension to move the content up when the keyboard is called
extension LoginViewController {
    
    //# Function to move the Keyboard-up on the first page
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}



