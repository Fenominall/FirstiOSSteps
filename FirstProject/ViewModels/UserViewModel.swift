//
//  UsernamePasswordViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

class UserViewModel {
    
    private(set) var user = User() {
        didSet {
            userUsername.value = user.username
        }
    }
    
    var userUsername: Box<String> = Box("")
    
    init(user: User = User()) {
        self.user = user
    }
    
}
