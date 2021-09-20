//
//  CustomTextField.swift
//  FirstProject
//
//  Created by Fenominall on 19.09.2021.
//

import UIKit

// MARK: Settings padding for UITextField
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

extension UITextField {
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if (isSecureTextEntry) {
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    func enablePasswordToggle() {
        
    }
}

