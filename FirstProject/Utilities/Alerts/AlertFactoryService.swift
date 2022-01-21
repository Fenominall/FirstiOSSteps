//
//  AlertFactoryService.swift
//  FirstProject
//
//  Created by Fenominall on 1/21/22.
//

import UIKit

protocol AlertFactoryService {
    var delegate: AlertActionDelegate? { get set }
    func build(alertData: AlertViewData) -> UIViewController
}

// Delegated to perform action on UIAlerts with deligation
protocol AlertActionDelegate: AnyObject {
    func okAction()
    func cancelAction()
}

// MARK: - AlertsFactory
class AlertsFactory: AlertFactoryService {
    var delegate: AlertActionDelegate?
    
    func build(alertData: AlertViewData) -> UIViewController {
        let viewCotroller = UIAlertController(title: alertData.title,
                                              message: alertData.message,
                                              preferredStyle: alertData.style)
        // Creating and adding to VC an OK action with a delegate
        if alertData.enableOkAction {
            let okAction = UIAlertAction(title: alertData.okActionTitle,
                                         style: alertData.okActionStyle) { [weak self] (_) in
                self?.delegate?.okAction()
            }
            viewCotroller.addAction(okAction)
        }
        // Creating and adding to VC an Cancel action with a delegate
        if alertData.enableCancelAction {
            let cancelAction = UIAlertAction(title: alertData.cancelActionTitle,
                                             style: alertData.cancelActionStyle) { [weak self] (_) in
                self?.delegate?.cancelAction()
            }
            viewCotroller.addAction(cancelAction)
        }
        
        return viewCotroller
    }
}

