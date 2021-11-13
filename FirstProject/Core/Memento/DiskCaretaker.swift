//
//  DiskCaretaker.swift
//  FirstProject
//
//  Created by Fenominall on 11/8/21.
//

import Foundation

// MARK: - Caretaker for the Memento design pattern
public final class DiskCaretaker {
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    
    // 1: You first declare a generic method that takes any object that conforms to Codable.
    public static func save<T: Codable>(_ object: T, to fileName: String) throws {
        do {
            // 2: You then call createDocumentURL to create a document URL for the given fileName.
            let url = createDocumentURL(withFileName: fileName)
            // 3: You use encoder to encode the object into data. This operation may throw an
            //    error, so you prefix it with try.
            let data = try encoder.encode(object)
            // 4: You call data.write to write the data to the given url. You use the atomic
            //    operator to instruct iOS to create a temporary file and then move it to the desired
            //    path. This has a small performance cost, but it ensures the file data will never be
            //    corrupted. It’s possible this operation may throw an error, so you must prefix it
            //    with try.
            try data.write(to: url, options: .atomic)
        } catch (let error){
            // 5: If you catch an error, you print the object and error to the console and then
            //    throw the error.
            print("Save failed: Object: '\(object)', " +
                  "Error: \(error)")
            throw error
        }
    }
    
    // 1: You declare a method for retrieving objects given a type and fileName, which is
    //    a String. This method first creates a file URL and calls retrieve(_:from:).
    //    You’ll soon see how it can be useful to pass either a String or URL at times to
    //    retrieve persisted objects.
    public static func retrieve<T: Codable>( _ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumentURL(withFileName: fileName)
        return try retrieve(T.self, from: url)
    }
    // 2: You also declare a method which takes a URL rather than a String, which does
    //    the actual loading. The previous method simply calls through to this one. You’ll
    //    need both, so both are public.
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            // 3: Here you attempt to create a Data instance from the given file url. It’s possible
            //            this operation may fail, so you prefix this call with try.
            let data = try Data(contentsOf: url)
            // 4: You then use decoder to decode the object into data. This operation may throw
            //            an error, so you prefix it with try.
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            // 5: If you catch an error, you print the url and error to the console and then
            //            throw the error.
            print("Retrieve failed: URL: `\(url)`, Error: `\(error)`")
            throw error
        }
    }
    
    
    
    public static func createDocumentURL(withFileName fileName: String) -> URL {
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory,
                                      in: .userDomainMask).first!
        return url.appendingPathComponent(fileName)
            .appendingPathExtension("json")
    }
}
