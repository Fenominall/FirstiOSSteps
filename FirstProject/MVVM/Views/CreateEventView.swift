//
//  CreateEventView.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import UIKit
import SnapKit

class CreateEventView: UIView {
    
    // MARK: - UIViewContainer
    private lazy var containerUIView: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    // MARK: - UITextFields
    private(set) lazy var createEventTextField: UITextField = {
        let createEventTextField = UITextField()
        createEventTextField.translatesAutoresizingMaskIntoConstraints = false
        createEventTextField.placeholder = "create event"
        createEventTextField.textAlignment = .center
        createEventTextField.borderStyle = .roundedRect
        return createEventTextField
    }()
    
    // MARK: - UIDatePicker
    private(set) lazy var eventDatePicker: UIDatePicker = {
        let eventDatePicker = UIDatePicker()
        eventDatePicker.translatesAutoresizingMaskIntoConstraints = false
        eventDatePicker.preferredDatePickerStyle = .automatic
        eventDatePicker.contentMode = .scaleToFill
        eventDatePicker.datePickerMode = .dateAndTime
        eventDatePicker.minuteInterval = 1
        return eventDatePicker
        
    }()
        
    // MARK: - UIButton
    private(set) lazy var createEventButton: UIButton = {
        let createEventButton = UIButton(type: .system)
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        createEventButton.setTitle("Create Event", for: .normal)
        return createEventButton
    }()
    
    // MARK: - UIStackView
    private lazy var contentStackView: UIStackView = {
       let contentStackView = UIStackView(arrangedSubviews: [createEventTextField,
                                                            eventDatePicker,
                                                            createEventButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.distribution = .fillProportionally
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        return contentStackView
    }()
    
    // MARK: - UIView initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }

}

// MARK: Configure auto-layout of UIElements
extension CreateEventView {
    func initializeUI() {
        backgroundColor = .white
        
        addSubview(containerUIView)
        containerUIView.addSubview(contentStackView)
        
        containerUIView.snp.makeConstraints {
            $0.edges.margins.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(containerUIView)
        }
        
        createEventTextField.snp.makeConstraints {
            $0.leadingMargin.trailingMargin.equalTo(containerUIView).inset(20)
        }
        
        eventDatePicker.snp.makeConstraints {
            $0.leadingMargin.equalTo(containerUIView).inset(50)
        }
        
    }
}
