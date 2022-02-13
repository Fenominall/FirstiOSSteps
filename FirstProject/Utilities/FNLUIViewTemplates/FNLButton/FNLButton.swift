//
//  FNLButton.swift
//  FirstProject
//
//  Created by Fenominall on 2/13/22.
//

import Foundation
import UIKit

class FNLButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(title: String,
         fontSize: CGFloat,
         fontWeight: UIFont.Weight,
         titleColor: UIColor) {
        super.init(frame: .zero)
        applyButtonPreset(title: title,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          titleColor: titleColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func applyButtonPreset(title: String,
                           fontSize: CGFloat,
                           fontWeight: UIFont.Weight,
                           titleColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
    }
}
