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
    
    private(set) lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    lazy var dateFormatter:  DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "EEEE, MMM d, yyyy, hh:mm a"
      formatter.timeZone = .current
      return formatter
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
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.margins.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leadingMargin.topMargin.equalTo(containerView).inset(8)
        }
        
//        containerView.addSubview(dateFormatter)
//        dateFormatter.snp.makeConstraints {
//            $0.topMargin.equalTo(titleLabel.snp_bottomMargin)
//            $0.leadingMargin.equalTo(titleLabel.snp.leading)
//        }
        
        
    }
}
