//
//  IssueDB.swift
//  secoTests
//
//  Created by Javier Calatrava on 28/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
import RealmSwift

class IssueDB: Object {

    @objc dynamic var route: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var surename: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var timestamp: Double = -1.0
    @objc dynamic var report: String = ""
    @objc dynamic var phone: String = ""


    // MARK: - Initializers
    convenience init(route: String,
                     name: String,
                     surename: String,
                     email: String,
                     timestamp: Double,
                     report: String,
                     phone: String) {

        self.init()
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
                  timestamp: issue.timestamp,
                  report: issue.report,
                  phone: issue.phone)
    }

    // MARK: - Realm
    override class func primaryKey() -> String? {
        return "route"
    }

    override class func indexedProperties() -> [String] {
        return []
    }

    override static func ignoredProperties() -> [String] {
        return []
    }
}
