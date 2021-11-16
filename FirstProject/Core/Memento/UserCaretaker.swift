//
//  UserCaretaker.swift
//  FirstProject
//
//  Created by Fenominall on 11/8/21.
//

import Foundation


public final class UserCaretaker {

    private let filename = "SavedUsersData"
    public var userGroup: User = User()


    public init() {

    }

    public func loadUserData() {
        if let userGroup = try? DiskCaretaker.retrieve(User.self, from: filename) {
            self.userGroup = userGroup

        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: filename,
                                 withExtension: "json")!
            self.userGroup = try! DiskCaretaker.retrieve(User.self, from: url)
            try! saveUserData()
        }
    }

    public func saveUserData() throws {
        try DiskCaretaker.save(userGroup, to: filename)
    }

}

