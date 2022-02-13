//
//  FNLLabel.swift
//  FirstProject
//
//  Created by Fenominall on 2/13/22.
//

import Foundation
import UIKit

class FNLLabel: UILabel {
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(with text: String,
         fontSize: CGFloat,
         fontWeight: UIFont.Weight,
         textColor: UIColor) {
        super.init(frame: .zero)
        applyLabelPreset(text: text,
                         fontSize: fontSize,
                         fontWeight: fontWeight,
                         textColor: textColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Helpers
    func applyLabelPreset(text: String,
                          fontSize: CGFloat,
                          fontWeight: UIFont.Weight,
                          textColor: UIColor) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: fontSize,
                                      weight: fontWeight)
        self.textColor = textColor
    }
}

