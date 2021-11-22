//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation

struct HomeViewModel {
    
    private var user: User = User() {
        didSet {
            do {
                user = try UserCaretaker.loadUserData()
                print(user.username)
                userName.value = user.username
            } catch {
                print("error")
            }
        }
    }
    
    var userName: Dynamic<String> = Dynamic("")

    init(user: User = User()) {
        self.user = user
    }
    
}
