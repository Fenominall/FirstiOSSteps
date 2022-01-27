//
//  Utilities.swift
//  FirstProject
//
//  Created by Fenominall on 12/12/21.
//

import Foundation
import UIKit

class Utilities {
    
    func inputContainerView(withLabel label: UILabel,
                            textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(label)
        label.anchor(top: view.bottomAnchor, left: view.leftAnchor, paddingTop: 8)
        
        view.addSubview(textField)
        textField.backgroundColor = .lightGrayAccent
        textField.anchor(top: label.bottomAnchor, left: label.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 48)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(top: textField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 5, height: 0.7)
        return view
    }
    
    func customTextField() -> UITextField {
        let textField = UITextField()
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }
    
    func newUIlabel(text: String,
                    fontSize: Int,
                    fontWeight: UIFont.Weight,
                    textAlignment: NSTextAlignment,
                    textColor: UIColor) -> UILabel {
        let newUIlabel = UILabel()
        newUIlabel.text = text
        newUIlabel.textAlignment = textAlignment
        newUIlabel.textColor = textColor
        newUIlabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        return newUIlabel
    }
    
    // Button with attributed title
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
    
}
