//
//  UserCaretaker.swift
//  FirstProject
//
//  Created by Fenominall on 11/8/21.
//

import Foundation


public final class UserCaretaker {

    // MARK: - Properties
    private static let fileName = "SavedUsersData"
    public static var newUser: User = User()

    // MARK: - Lifecycle
    public init() {}
    
    // MARK: - Helpers
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
    ///save user data
    private static func save() throws {
        try DiskCaretaker.save(newUser, to: fileName)
    }
    
    /// create new user
    public static func createUser(user: User) throws {
        newUser = user
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }

}

