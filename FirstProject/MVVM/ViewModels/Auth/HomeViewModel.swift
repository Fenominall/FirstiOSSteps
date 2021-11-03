//
//  HomeViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 11/1/21.
//

import Foundation

class HomeViewModel {

    private var user = User() {
        didSet {
            username.value = user.username
            password.value = user.password
        }
    }

    var username: Box<String> = Box("")
    var password: Box<String> = Box("")

    init(user: User = User()) {
        self.user = user
    }

}
