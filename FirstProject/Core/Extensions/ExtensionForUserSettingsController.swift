//
//  TextFieldExtensions.swift
//  FirstProject
//
//  Created by Fenominall on 20.07.2021.
//

import Foundation
import UIKit


// MARK: Extension to handle Dismiss/Hide The KeyBoard
extension UserSettingsViewController: UITextFieldDelegate {
    
    /// Dismiss keyboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
}


//MARK: Extension to move the content up when the keyboard is called
extension UserSettingsViewController {
    
    
    //# Function to move the Keyboard-up on the first page
    func observerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -80, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
}
