//
//  Event.swift
//  FirstProject
//
//  Created by Fenominall on 11/15/21.
//

import Foundation

struct Event: Codable {
  var date: Date
  var name: String
  
  static func getTestData() -> [Event] {
    let eventNames = ["Review UITableView lesson and videos", "CocoaPods Peer Lab", "Unit Assessment", "iOS Soho Meetup", "112 miles birthday bike ride 🥳", "Ladies who code", "facebook", "iOS Study Group", "Redo BlackJack Project for OOP practice", "Preview Unit 3 over the weekend", "Preview Unit 3 over the weekend", "Preview Unit 3 over the weekend", "Preview Unit 3 over the weekend", "Preview Unit 3 over the weekend", "Preview Unit 3 over the weekend"]
    var events = [Event]()
    for eventName in eventNames {
      let event = Event(date: Date(), name: eventName)
      events.append(event)
    }
    return events
  }
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name
        && lhs.date == rhs.date
    }
}
