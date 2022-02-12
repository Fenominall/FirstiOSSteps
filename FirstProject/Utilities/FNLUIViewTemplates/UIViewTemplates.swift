//
//  Utilities.swift
//  FirstProject
//
//  Created by Fenominall on 12/12/21.
//

import Foundation
import UIKit

class UIViewTemplates {

    func newUILabel(text: String,
                    fontSize: Int,
                    fontWeight: UIFont.Weight,
                    textAlignment: NSTextAlignment,
                    textColor: UIColor) -> UILabel {
        let newUILabel = UILabel()
        newUILabel.text = text
        newUILabel.textAlignment = textAlignment
        newUILabel.textColor = textColor
        newUILabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        newUILabel.translatesAutoresizingMaskIntoConstraints = false
        return newUILabel
    }

    func customButton(title: String,
                              fontSize: Int,
                              fontWeight: UIFont.Weight,
                              tintColor: UIColor) -> UIButton {
        let customButton = UIButton(type:.system)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setTitle(title, for: .normal)
        customButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontSize), weight: fontWeight)
        customButton.tintColor = tintColor
        customButton.layer.shadowColor = UIColor.black.cgColor
        customButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.5)
        customButton.layer.shadowRadius = 2.0
        customButton.layer.shadowOpacity = 0.5
        return customButton
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
