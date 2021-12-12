//
//  UIButtonConfigurationExtension.swift
//  FirstProject
//
//  Created by Fenominall on 11/22/21.
//

import Foundation
import UIKit

extension UIButton.Configuration {
    
    static func lightGrayButton() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .filled()
        configuration.baseBackgroundColor = .lightGrayAccent
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .small
        configuration.buttonSize = .large
        configuration.titleAlignment = .center
        return configuration
    }
    
    // Button to place an image inside a UITextField
    static func placeButtonInTextField() -> UIButton.Configuration {
        var configuration: UIButton.Configuration = .plain()
        configuration.imagePlacement = .trailing
        configuration.baseForegroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -12, bottom: 0, trailing: 0)
        return configuration
    }
}



