//
//  Issue.swift
//  seco
//
//  Created by Javier Calatrava on 28/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct Issue {
    var route: String = ""
    var name: String = ""
    var surename: String = ""
    var email: String = ""
    var timestamp: Double = -1.0
    var report: String = ""
    var phone: String = ""

    // MARK: - Constructor/Initializers
    init(route: String,
         name: String,
         surename: String,
         email: String,
         timestamp: Double,
         report: String,
         phone: String) {
        self.route = route
        self.name = name
        self.surename = surename
        self.email = email
        self.timestamp = timestamp
        self.report = report
        self.phone = phone
    }

    init(issueDB: IssueDB) {
        self.init(route: issueDB.route,
                  name: issueDB.name,
                  surename: issueDB.surename,
                  email: issueDB.email,
                  timestamp: issueDB.timestamp,
                  report: issueDB.report,
                  phone: issueDB.phone)
    }

    init(issueVM: IssueVM) {
        self.init(route: issueVM.route,
                  name: issueVM.name,
                  surename: issueVM.surename,
                  email: issueVM.email,
                  timestamp: issueVM.timestamp.timeIntervalSince1970,
                  report: issueVM.report,
                  phone: issueVM.phone)
    }
}
