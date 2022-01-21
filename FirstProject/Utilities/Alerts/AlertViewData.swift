//
//  AlertViewData.swift
//  FirstProject
//
//  Created by Fenominall on 1/21/22.
//

import UIKit

// MARK: - Model for UIAlert to be used for AlertFactoryService
struct AlertViewData {
    let title: String
    let message: String
    let style: UIAlertController.Style
    let enableOkAction: Bool
    let okActionTitle: String
    let okActionStyle: UIAlertAction.Style
    let enableCancelAction: Bool
    let cancelActionTitle: String
    let cancelActionStyle: UIAlertAction.Style
    
    init(title: String,
                  message: String,
                  style: UIAlertController.Style,
                  enableOkAction: Bool,
                  okActionTitle: String,
                  okActionStyle: UIAlertAction.Style,
                  enableCancelAction: Bool,
                  cancelActionTitle: String,
                  cancelActionStyle: UIAlertAction.Style) {
        self.title = title
        self.message = message
        self.style = style
        self.enableOkAction = enableOkAction
        self.okActionTitle = okActionTitle
        self.okActionStyle = okActionStyle
        self.enableCancelAction = enableCancelAction
        self.cancelActionTitle = cancelActionTitle
        self.cancelActionStyle = cancelActionStyle
    }
}
