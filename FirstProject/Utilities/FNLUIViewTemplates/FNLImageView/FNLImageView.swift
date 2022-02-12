//
//  FNLImageView.swift
//  FirstProject
//
//  Created by Fenominall on 2/12/22.
//

import Foundation
import UIKit

class FNLImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    init(with preset: AppImages, renderMode: UIImage.RenderingMode = .alwaysOriginal) {
        super.init(frame: .zero)
        setupView()
        applyImagePreset(preset, renderMode: renderMode)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func applyImagePreset(_ preset: AppImages, renderMode: UIImage.RenderingMode = .alwaysOriginal) {
        image = preset.image?.withRenderingMode(renderMode)
    }
    
    private func setupView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
