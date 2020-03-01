//
//  DBManagerUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 28/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class DBManagerUT: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DBManager.shared.reset()
    }

    // MARK: - Issue
    func test_DBIsEmptyAtTheBeggining() {
        //Given
        //When
        //Then
        XCTAssertEqual(DBManager.shared.getIssues().count, 0)
    }
    func test_createIssue() {
        //Given
        //When
        let issueDB = IssueDB(route: "1", name: "Sara", surename: "Gutierrez", email: "sagu@mailinator.com", timestamp: 123, report: "blah, blah", phone: "123456789")
        DBManager.shared.create(issueDB: issueDB)
        //Then
        XCTAssertEqual(DBManager.shared.getIssues().count, 1)
        guard let issueDBStored = DBManager.shared.getIssues().first else {
            XCTFail()
            return
        }
        XCTAssertEqual(issueDBStored.route, "1")
        XCTAssertEqual(issueDBStored.name, "Sara")
        XCTAssertEqual(issueDBStored.surename, "Gutierrez")
        XCTAssertEqual(issueDBStored.email, "sagu@mailinator.com")
        XCTAssertEqual(issueDBStored.timestamp, 123)
        XCTAssertEqual(issueDBStored.report, "blah, blah")
        XCTAssertEqual(issueDBStored.phone, "123456789")
    }

    func test_updateIssue() {

        let issueDB = IssueDB(route: "1",
                              name: "Sara",
                              surename: "Gutierrez",
                              email: "sagu@mailinator.com",
                              timestamp: 123,
                              report: "blah, blah",
                              phone: "123456789")
        DBManager.shared.create(issueDB: issueDB)
        //Given
        let issueDBNew = IssueDB(route: "1",
                                 name: "Juan",
                                 surename: "Sino",
                                 email: "jusi@mailinator.com",
                                 timestamp: 53,
                                 report: "plat, plat",
                                 phone: "2222222222")
        DBManager.shared.create(issueDB: issueDBNew)
        //When
        XCTAssertEqual(DBManager.shared.getIssues().count, 1)
        guard let issueDBStored = DBManager.shared.getIssues().first else {
            XCTFail()
            return
        }
        XCTAssertEqual(issueDBStored.route, "1")
        XCTAssertEqual(issueDBStored.name, "Juan")
        XCTAssertEqual(issueDBStored.surename, "Sino")
        XCTAssertEqual(issueDBStored.email, "jusi@mailinator.com")
        XCTAssertEqual(issueDBStored.timestamp, 53)
        XCTAssertEqual(issueDBStored.report, "plat, plat")
        XCTAssertEqual(issueDBStored.phone, "2222222222")
    }


}
