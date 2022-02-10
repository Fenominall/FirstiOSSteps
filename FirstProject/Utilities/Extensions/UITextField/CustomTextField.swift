//
//  CustomTextField.swift
//  FirstProject
//
//  Created by Fenominall on 19.09.2021.
//

import UIKit

// MARK: Setting paddings for UITextField
class CustomTextField: UITextField {
    
    // Bindings for the textField
    var textChanged :(String) -> () = { _ in }
    
    
    func bind(callback :@escaping (String) -> ()) {
       
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField :UITextField) {
        
        self.textChanged(textField.text!)
    }
    
    // Setting up the padding for UITextField
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 45,
        bottom: 10,
        right: 20
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}


// MARK: Overriding isSecureTextEntry an becomeFirstResponder to have text returned after toggling isSecureTextEntry bool
extension CustomTextField {
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
}

// MARK: Adding a single line border for UITextField
extension CustomTextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGrayAccent?.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

// MARK: Create toggling UIButton
private let toggleButton = UIButton(type: .custom)

extension CustomTextField {
    
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
