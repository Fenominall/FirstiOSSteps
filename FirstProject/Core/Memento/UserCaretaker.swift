//
//  UserCaretaker.swift
//  FirstProject
//
//  Created by Fenominall on 11/8/21.
//

import Foundation


public final class UserCaretaker {

    private static let fileName = "SavedUsersData"
    public static var newUser: User = User()


    public init() {

    }

    public static func loadUserData() throws -> User{
        if newUser == newUser {
            do {
                newUser = try DiskCaretaker.retrieve(User.self,
                                                    from: fileName)
            } catch {
                throw DataPersistenceError.decodingError(error)
            }
        } else {
            do {
                let url = DiskCaretaker.createDocumentURL(withFileName: fileName)
                newUser = try DiskCaretaker.retrieve(User.self,
                                                    from: url)
                try? save()
            } catch {
                throw DataPersistenceError.fileDoesNotExist(fileName)
            }
        }
        return newUser
    }
    
    private static func save() throws {
        try DiskCaretaker.save(newUser, to: fileName)
    }
    
    public static func createUser(user: User) throws {
        newUser = user
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }

}

