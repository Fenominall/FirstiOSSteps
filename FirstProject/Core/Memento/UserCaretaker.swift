//
//  UserCaretaker.swift
//  FirstProject
//
//  Created by Fenominall on 11/8/21.
//

import Foundation


//public final class UserCaretaker {
//
//    private let filename = "SavedUsersData"
//    public var userGroup: [User] = []
//
//
//    public init() {
//
//    }
//
//    public func loadUserGroup() {
//        if let userGroup = try? DiskCaretaker.retrieve([User].self, from: filename) {
//            self.userGroup = userGroup
//
//        } else {
//            let bundle = Bundle.main
//            let url = bundle.url(forResource: filename,
//                                 withExtension: "json")!
//            self.userGroup = try! DiskCaretaker.retrieve([User].self, from: url)
//            try! save()
//        }
//    }
//
//    public func save() throws {
//        try DiskCaretaker.save(userGroup, to: filename)
//    }
//
//}

