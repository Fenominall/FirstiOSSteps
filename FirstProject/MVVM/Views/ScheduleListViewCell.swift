//
//  ScheduleListView.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import UIKit
import SnapKit

public class ScheduleListViewCell: UITableViewCell {
    
    static let cellID = "EvenTableViewCell"
    
    private lazy var containerView: UIView = {
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private(set) lazy var eventTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    private(set) lazy var eventDetailTextLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize:12)
        return titleLabel
    }()
    
    private(set) lazy var progressImage: UIButton = {
        let image = UIButton()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setImage(UIImage(systemName: "circle"), for: .normal)
        return image
    }()
    
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        containerView.backgroundColor = selected ? UIColor.lightGray : UIColor.darkGray
        
    }
    
}


extension ScheduleListViewCell {
    func configure() {
        containerView.backgroundColor = .darkGray
        
        addSubview(containerView)
        containerView.addSubview(eventTitleLabel)
        containerView.addSubview(eventDetailTextLabel)
        containerView.addSubview(progressImage)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        eventTitleLabel.snp.makeConstraints {
            $0.leadingMargin.topMargin.equalTo(containerView).inset(20)
        }
        
        eventDetailTextLabel.snp.makeConstraints {
            $0.top.equalTo(eventTitleLabel.snp.bottom)
            $0.leading.equalTo(eventTitleLabel.snp.leading)
        }
        
        progressImage.snp.makeConstraints {
            $0.trailingMargin.topMargin.equalTo(containerView).inset(25)
//            $0.centerY.equalTo(containerView.snp.centerY)
        }
        
    }
}
