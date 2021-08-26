//
//  UsernamePasswordViewModel.swift
//  FirstProject
//
//  Created by Fenominall on 17.07.2021.
//

class UserSettingsViewModel {
    
    var username: Box<String> = Box("")
    var password: Box<String> = Box("")
    
    init(username: String, password: String) {
        self.username = Box<String>(username)
        self.password = Box<String>(password)
    }
    
}

// class UserSettingsViewModel {
    
//     // Data binding     
//     var usernameTitle = Box(nil)
    
//     var user: User? {
//         didSet {
//             guard let user = user else {
//             title.value - nil
//             return
//             }
//             title.value = "\(user.username)"
//         }
//     }
// }
