//
//  UsernamePasswordViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

import Foundation


class DisplayUserViewModel {
    
    var userViewModel: [UserViewModel] = [UserViewModel]()
    
    private func populateUser() {
        
//        let user = defaults.string(forKey: LoginViewModel.strogaeKey)
        
    }
    
}


class UserViewModel {
    
    var username: String
    
    init(user: User) {
        self.username = user.username
    }
    
}
