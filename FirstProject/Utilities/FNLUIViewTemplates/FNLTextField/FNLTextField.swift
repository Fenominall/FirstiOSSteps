//
//  FNLTextField.swift
//  FirstProject
//
//  Created by Fenominall on 2/14/22.
//

import Foundation
import UIKit

class FNLTextField: UITextField {

    // MARK: - Properties
    
    // Bindings for the textField
    var textChanged :(String) -> () = { _ in }
    
    // Creating toggling UIButton
    private let toggleButton = UIButton(type: .custom)
    
    // Overriding isSecureTextEntry an becomeFirstResponder to have text returned after toggling isSecureTextEntry bool
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    // Setting up the padding for UITextField
    var textPadding = UIEdgeInsets(top: 10,
                                   left: 45,
                                   bottom: 10,
                                   right: 20)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    

    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Helpers

    func bind(callback :@escaping (String) -> ()) {
       
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField :UITextField) {
        
        self.textChanged(textField.text!)
    }
}

// MARK: - Bottom border for the TextField
extension FNLTextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGrayAccent?.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

// MARK: - Adding Toggle Button to the TextField
extension FNLTextField {
    
    func enablePasswordToggle() {
        
        toggleButton.sizeToFit()
        toggleButton.configuration = .placeButtonInTextField()
        toggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        toggleButton.isHidden = false
        rightView = toggleButton
        rightViewMode = .always
        toggleButton.alpha = 0.7
    }
   
    @objc func togglePasswordView() {
        if isSecureTextEntry {
            let eyeFill = AppImages.eyeFill.image
            toggleButton.setImage(eyeFill, for: .normal)
            isSecureTextEntry.toggle()
        } else {
            let eyeSlash = AppImages.eyeSlash.image
            toggleButton.setImage(eyeSlash, for: .normal)
            isSecureTextEntry.toggle()
        }
    }
}

