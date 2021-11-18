//
//  EventPersistenceHelper.swift
//  FirstProject
//
//  Created by Fenominall on 11/17/21.
//

import Foundation

// 1. Declared a new class called EventPersistenceHelper. You’ll use this to save
//  and retrieve Event objects.
final class EventPersistenceHelper {
    
    // MARK: - Properties
    // 2 Declared two properties: fileName defines the file where you’ll save and
    //    retrieve Event objects; events will hold onto the
    //    Event that are in use.
    private static let fileName = "eventsData"
    // array of events
    private static var events: [Event] = []
    
    // MARK: - Object lifecycle
    //    private init() {}
    
    static func loadEvents() throws -> [Event]{
        if events.isEmpty {
            do {
                events = try DiskCaretaker.retrieve([Event].self,
                                                    from: fileName)
            } catch {
                throw DataPersistenceError.decodingError(error)
            }
        } else {
            do {
                let url = DiskCaretaker.createDocumentURL(withFileName: fileName)
                events = try DiskCaretaker.retrieve([Event].self,
                                                    from: url)
                try? save()
            } catch {
                throw DataPersistenceError.fileDoesNotExist(fileName)
            }
        }
        return events
    }
    
//     read - load (retrieve) items from documents directory
//        static func loadEvents() throws -> [Event] {
//          // we need access to the filename URL that we are reading from
//            let url = DiskCaretaker.createDocumentURL(withFileName: fileName)
//
//          // check if file exist
//          // to convert URL to String we use .path on the URL
//          if FileManager.default.fileExists(atPath: url.path) {
//            if let data = FileManager.default.contents(atPath: url.path) {
//              do {
//                events = try JSONDecoder().decode([Event].self, from: data)
//              } catch {
//                throw DataPersistenceError.decodingError(error)
//              }
//            } else {
//                throw DataPersistenceError.notData
//            }
//          }
//          else {
//            throw DataPersistenceError.fileDoesNotExist(fileName)
//          }
//          return events
//        }
    
    // MARK: - Instance Methods
    // 5
    private static func save() throws {
        try DiskCaretaker.save(events, to: fileName)
    }
    
    // re-ordering objects
    public static func reorderingEvents(events: [Event]) {
        self.events = events
        try? save()
    }
    
    // create - save item to documents directory
    static func create(event: Event) throws {
        // append new event to the events array
        events.append(event)
        do {
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    
    // delete - remove item from documents directory
    static func delete(event index: Int) throws {
        // remove the item from the events array
        events.remove(at: index)
        
        // save events array yo the documents directory
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
    
    
}
