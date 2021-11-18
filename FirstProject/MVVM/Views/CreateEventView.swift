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
        createEventTextField.placeholder = "create event"
        createEventTextField.textAlignment = .center
        createEventTextField.borderStyle = .roundedRect
        return createEventTextField
    }()
    
    // MARK: - UIDatePicker
    private(set) lazy var eventDatePicker: UIDatePicker = {
        let eventDatePicker = UIDatePicker()
        eventDatePicker.translatesAutoresizingMaskIntoConstraints = false
        eventDatePicker.preferredDatePickerStyle = .wheels
        eventDatePicker.tintColor = .white
        eventDatePicker.contentMode = .scaleToFill
        eventDatePicker.datePickerMode = .dateAndTime
        eventDatePicker.minuteInterval = 1
        return eventDatePicker
    }()
        
    // MARK: - UIButton
    private(set) lazy var createEventButton: UIButton = {
        let createEventButton = UIButton(type: .system)
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.tintColor = .white
        return createEventButton
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
        backgroundColor = .lightGray
        
        addSubview(containerUIView)
        containerUIView.addSubview(eventDatePicker)
        containerUIView.addSubview(createEventTextField)
        containerUIView.addSubview(createEventButton)
        
        containerUIView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        eventDatePicker.snp.makeConstraints {
            $0.centerX.centerY.equalTo(containerUIView)
        }
        
        createEventTextField.snp.makeConstraints {
            $0.bottom.equalTo(eventDatePicker.snp_topMargin).inset(-25)
            $0.leading.trailing.equalTo(containerUIView).inset(30)
            $0.height.equalTo(48)
        }
        
        createEventButton.snp.makeConstraints {
            $0.top.equalTo(eventDatePicker.snp_bottomMargin).inset(-15)
            $0.centerX.equalTo(containerUIView)
        }
    }
}
