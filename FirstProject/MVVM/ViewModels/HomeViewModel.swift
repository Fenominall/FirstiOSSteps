//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation

class HomeViewModel {
    
    private var user: User {
        didSet {
            userName.value = user.username
        }
    }
    
    var userName: Dynamic<String> = Dynamic("")

    init(user: User = User()) {
        self.user = user
    }
    
}
