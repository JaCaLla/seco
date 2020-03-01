//
//  IssueVM.swift
//  seco
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation


struct IssueVM {
    var route:String = ""
    var name:String = ""
    var surename:String = ""
    var email:String = ""
    var timestamp: Date = Date()
    var report: String = ""
    var phone: String = ""
    
    // MARK: - Constructor/Initializers
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
    
    init(issue: Issue) {
        self.init(route: issue.route,
                  name: issue.name,
                  surename: issue.surename,
                  email: issue.email,
                  timestamp: issue.timestamp < 0 ? Date() : Date(timeIntervalSince1970: TimeInterval(issue.timestamp)),
                  report: issue.report,
                  phone:issue.phone)
    }
}
