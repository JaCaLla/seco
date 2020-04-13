//
//  Person.swift
//  seco
//
//  Created by Javier Calatrava on 11/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
import Combine

class IssueUI: ObservableObject {
    var route: String = ""
   @Published var name: String = ""
   @Published var surename: String = ""
    @Published var email: String = ""
    @Published var timestamp: Date = Date()
    @Published var report: String = ""
    @Published var phone: String = ""
    
    init() {
    }
    
    init(route:String,
         name:String,
         surename:String,
         email:String,
         timestamp: Date,
         report:String,
         phone: String) {
        self.route = route
        self.name = name
        self.surename = surename
        self.email = email
        self.timestamp = timestamp
        self.report = report
        self.phone = phone
    }
    
    convenience init(issue: Issue) {
        self.init(route: issue.route,
                  name: issue.name,
                  surename: issue.surename,
                  email: issue.email,
                  timestamp: issue.timestamp < 0 ? Date() : Date(timeIntervalSince1970: TimeInterval(issue.timestamp)),
                  report: issue.report,
                  phone:issue.phone)
    }
}
