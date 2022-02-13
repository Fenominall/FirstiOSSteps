//
//  FNLAttributedButton.swift
//  FirstProject
//
//  Created by Fenominall on 2/13/22.
//

import Foundation
import UIKit

class FNLAttributedButton: FNLButton {
    
    init(_ firstPart: String, _ secondPart: String) {
        super.init(frame: .zero)
        attributedButton(firstPart, secondPart)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Button with attributed title
    func attributedButton(_ firstPart: String, _ secondPart: String) {
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
