//
//  CreateEventController.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import Foundation
import UIKit

class CreateEventController: UIViewController, Coordinating {
        
    // MARK: - Properties
    var coordinator: Coordinator?
    var event: Event? // default value is nil

    private var eventView = CreateEventView()
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        super.loadView()
        eventView.createEventTextField.delegate = self
        view = eventView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setTargets() {
        eventView.eventDatePicker.addTarget(self, action: #selector(dataPicketChanged(_:)), for: .valueChanged)
    }

    @objc private func dataPicketChanged(_ sender: UIDatePicker) {
        // update date of event
        event?.date = sender.date
    }
}

extension CreateEventController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // dismiss the keyabord
        textField.resignFirstResponder()
        // update name of event
        event?.name = textField.text ?? "no name"
        return true
    }
 
    
}
