//
//  CustomTextField.swift
//  FirstProject
//
//  Created by Fenominall on 19.09.2021.
//

import UIKit

// MARK: Setting paddings for UITextField
class CustomTextField: UITextField {
    
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
extension UITextField {
    func addBottomBorder() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor(hex: "#595959")?.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}



// MARK: Create toggling UIButton
private let toggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        
        toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.sizeToFit()
        toggleButton.tintColor = .white
        toggleButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        toggleButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        rightView = toggleButton
        rightViewMode = .always
        toggleButton.alpha = 0.4
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        
        if isSecureTextEntry {
            toggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            isSecureTextEntry.toggle()
        } else {
            toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            isSecureTextEntry.toggle()
        }
    }
}

