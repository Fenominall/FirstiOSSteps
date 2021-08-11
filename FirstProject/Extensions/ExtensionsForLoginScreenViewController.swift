//
//  MyExtensions.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

import Foundation
import UIKit


// MARK: Extension to handle Dismiss/Hide The KeyBoard
extension LoginScreenViewController: UITextFieldDelegate {

    /// Dismiss/Hide the KeyBoard.
    /// - Parameter textField: UITextField
    /// - Returns: resignFirstResponder()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    /// Dismiss keboard when touching in any part of the view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//
//    //# Function to return false if the input in UITextFiled is " " or "    ".
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == " " || string == "    ") {
//            return false
//        }
//        return true
//    }
}

//MARK: Extension to move the content up when the keyboard is called
extension LoginScreenViewController {
    
    //# Function to move the Keyboardup on the first page
    func observeKeyboardNofitications() {
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

//  MARK: Handaling navigation controller to disable it
extension LoginScreenViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
}


