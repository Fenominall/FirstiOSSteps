//
//  CreateEventController.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import Foundation
import UIKit

protocol AddEventDelegate: AnyObject {
    func eventCreated(didCreated event: Event)
}

class CreateEventController: UIViewController {
        
    // MARK: - Instance Properties
    var event: Event? // default value is nil
    weak var addEventDelegate: AddEventDelegate?
    private var eventView = CreateEventView()
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        view = eventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
    }

    // MARK: - Selectors
    @objc private func didTapCreateButton(_ sender: Any) {
        let selectedDate = eventView.eventDatePicker.date
        let eventName = eventView.createEventTextField.text ?? "No name..."
        
        let event = Event(date: selectedDate, name: eventName)
        addEventDelegate?.eventCreated(didCreated: event)
    }
    
    // MARK: - Helpers
    private func setTargets() {
        eventView.createEventTextField.delegate = self
        eventView.createEventButton.addTarget(self, action: #selector(didTapCreateButton(_:)), for: .touchUpInside)
    }
}

extension CreateEventController: UITextFieldDelegate {
    
    //handle Dismiss/Hide The KeyBoard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
