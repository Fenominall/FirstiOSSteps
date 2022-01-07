//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation

class HomeViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
}

extension HomeViewModel {
    var username: String {
        return user.username
    }
}
