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
}

extension CreateEventController: UITextFieldDelegate {

}
