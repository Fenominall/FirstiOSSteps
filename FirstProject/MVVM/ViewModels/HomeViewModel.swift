//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation

final class HomeViewModel {
    
    /// Variable which stores User username
    var username: String?
    
    // Initializer that helps to retrieve UserData with the help of UserCaretaker class
    init() {
        do {
            let user = try UserCaretaker.loadUserData()
            self.username = user.username
        } catch (let error) {
            print("DEBUG: Error loading user data \(error)")
        }
    }
}

