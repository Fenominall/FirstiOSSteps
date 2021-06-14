//
//  PageCell.swift
//  FirstProject
//
//  Created by Fenominall on 14.06.2021.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return}
            pirateHead.image = UIImage(named: unwrappedPage.imageName)
            
            let attributeText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            attributeText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
            descriptionTextView.attributedText = attributeText
            descriptionTextView.textAlignment = .center
        }
    }
    
    
    let pirateHead: UIImageView = {
        let pirateHead = UIImageView()
        pirateHead.translatesAutoresizingMaskIntoConstraints = false
        pirateHead.image = UIImage(named: "pirate")
        pirateHead.contentMode = .scaleAspectFit
        return pirateHead
    }()
    
    let descriptionTextView: UITextView = {
        let descriptionTextView = UITextView()
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        let attributeText = NSMutableAttributedString(string: "Join us today in our fan and games", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        attributeText.append(NSAttributedString(string: "\n\n\nAre you readt for loads and loads of fun? Don`t wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        descriptionTextView.attributedText = attributeText
        descriptionTextView.textAlignment = .center
        descriptionTextView.isEditable = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.backgroundColor = .white
        return descriptionTextView
    }()
    
    let topImageContainer: UIView = {
        let topImageContainer = UIView()
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
     
        return topImageContainer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        topImageContainerConstraints()
    }
    
    func topImageContainerConstraints() {
        addSubview(topImageContainer)
        
        topImageContainer.addSubview(pirateHead)
        addSubview(descriptionTextView)
    
        
        NSLayoutConstraint.activate([
            topImageContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            topImageContainer.topAnchor.constraint(equalTo: topAnchor),
            topImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pirateHead.heightAnchor.constraint(equalToConstant: 200),
            pirateHead.widthAnchor.constraint(equalToConstant: 200),
            pirateHead.centerXAnchor.constraint(equalTo: topImageContainer.centerXAnchor),
            pirateHead.centerYAnchor.constraint(equalTo: topImageContainer.centerYAnchor),
            pirateHead.heightAnchor.constraint(equalTo: topImageContainer.heightAnchor, multiplier: 0.75),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainer.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24)
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
