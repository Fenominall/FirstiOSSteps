//
//  Images.swift
//  FirstProject
//
//  Created by Fenominall on 10/30/21.
//

import Foundation
import UIKit

struct AppImages {
    static let appIcon = UIImage(named: "appIconF")!
    static let loginBackgroundImage = UIImage(named: "loginImage")!
    static let lightCircle = UIImage(named: "lightCircle")!
    static let userImage = UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
    static let homeBackgroundImage = UIImage(named: "blob-scene")!
    static let waves = UIImage(named: "waves")!
    static let plusIcon = UIImage(named: "plusIcon")!
    static let git = UIImage(named: "git")!
    static let eyeFill = UIImage(named: "eye.fill")
    static let eyeSlash = UIImage(named: "eye.slash")
}


enum AppImagess {
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

extension AppImagess {
    var image: UIImage? {
        switch self {
        case .appIcon:
            return UIImage(named: "appIconF")
        case .loginBackgroundImage:
            return UIImage(named: "loginImage")
        case .lightCircle:
            return UIImage(named: "lightCircle")
        case .userDefaultImage:
            return UIImage(named: "user")?.withRenderingMode(.alwaysOriginal)
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

class BaseImageView: UIImageView {
    
    init(with preset: AppImagess) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        applyImagePreset(preset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyImagePreset(_ preset: AppImagess) {
        image = preset.image
    }
}
