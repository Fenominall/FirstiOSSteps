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
}

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name
        && lhs.date == rhs.date
    }
}
