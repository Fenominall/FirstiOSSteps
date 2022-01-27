//
//  ScheduleListView.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import UIKit
import SnapKit

public class ScheduleListViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "EvenTableViewCell"

    private(set) lazy var eventTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
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
    private lazy var eventStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [eventTitleLabel,
                                                  eventDetailTextLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 4
        return stack
    }()
    
    public override var isSelected: Bool {
        didSet {
            eventTitleLabel.textColor = isSelected ? .black : .white
            eventDetailTextLabel.textColor = isSelected ? .black : .white
        }
    }
    
    // MARK: - Lifecycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    // MARK: - Helpers
    func configure() {
        
        backgroundColor = .darkWeb
        
        addSubview(eventStack)
        eventStack.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: 5,
                          paddingLeft: 30,
                          paddingBottom: 5,
                          paddingRight: 30)
    }
}
