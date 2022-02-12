//
//  Images.swift
//  FirstProject
//
//  Created by Fenominall on 10/30/21.
//

import Foundation
import UIKit

enum AppImages {
    case appIcon
    case loginBackgroundImage
    case lightCircle
    case userDefaultImage
    case homeBackgroundImage
    case editProfileBackgroundImage
    case plusIcon
    case git
    case eyeFill
    case eyeSlash
}

extension AppImages {
    var image: UIImage? {
        switch self {
        case .appIcon:
            return UIImage(named: "appIconF")
        case .loginBackgroundImage:
            return UIImage(named: "loginImage")
        case .lightCircle:
            return UIImage(named: "lightCircle")
        case .userDefaultImage:
            return UIImage(named: "user")
        case .homeBackgroundImage:
            return UIImage(named: "blob-scene")
        case .editProfileBackgroundImage:
            return UIImage(named: "waves")
        case .plusIcon:
            return UIImage(named: "plusIcon")
        case .git:
            return UIImage(named: "git")
        case .eyeFill:
            return UIImage(named: "eye.fill")
        case .eyeSlash:
            return UIImage(named: "eye.slash")
        }
    }
}

