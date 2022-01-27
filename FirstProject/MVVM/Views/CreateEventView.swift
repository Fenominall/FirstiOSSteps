//
//  CreateEventView.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import UIKit
import SnapKit

class CreateEventView: UIView {
    
    // MARK: - UITextFields
    private(set) lazy var createEventTextField: UITextField = {
        let createEventTextField = UITextField()
        createEventTextField.placeholder = "create event"
        createEventTextField.textAlignment = .center
        createEventTextField.borderStyle = .roundedRect
        createEventTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return createEventTextField
    }()
    
    // MARK: - UIDatePicker
    private(set) lazy var eventDatePicker: UIDatePicker = {
        let eventDatePicker = UIDatePicker()
        eventDatePicker.preferredDatePickerStyle = .wheels
        eventDatePicker.tintColor = .white
        eventDatePicker.layer.backgroundColor = .init(red: 255/2, green: 138/15, blue: 187/69, alpha: 1)
        eventDatePicker.contentMode = .scaleToFill
        eventDatePicker.datePickerMode = .dateAndTime
        eventDatePicker.minuteInterval = 1
        eventDatePicker.layer.cornerRadius = 10
        return eventDatePicker
    }()
        
    // MARK: - UIButton
    private(set) lazy var createEventButton: UIButton = {
        let createEventButton = UIButton(type: .system)
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.tintColor = .white
        createEventButton.backgroundColor = .orange
        createEventButton.layer.cornerRadius = 10
        createEventButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return createEventButton
    }()
    
    private lazy var createEventStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [createEventTextField,
                                                  eventDatePicker,
                                                  createEventButton])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
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
        backgroundColor = .darkWeb
        
        addSubview(createEventStack)
        createEventStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
