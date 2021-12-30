//
//  ShakeView.swift
//  FirstProject
//
//  Created by Fenominall on 24.07.2021.
//
import Foundation
import UIKit



// MARK: - Manager class for phones vibrations
final class HapticsManager {
    
    // MARK: - Properties
    static let shared = HapticsManager()
    
    // MARK: - Lifecycle
    private init() {}
    
    // MARK: - Helpers
    private func selectionVibrate() {
        DispatchQueue.main.async {
            
            let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
            selectionFeedbackGenerator.prepare()
            selectionFeedbackGenerator.selectionChanged()
        }
    }
    
    public func vibrateForType(for type: UINotificationFeedbackGenerator.FeedbackType) {
        
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}
