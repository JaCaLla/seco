//
//  IssueUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 28/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco

class IssueUT: XCTestCase {

    func test_initalizerIssue() {
        // Given
        let issueDB = IssueDB(route: "1",
                              name: "Sara",
                              surename: "Gutierrez",
                              email: "sagu@mailinator.com",
                              timestamp: 123,
                              report: "blah, blah",
                              phone: "123456789")
        // When
        let issue = Issue(issueDB: issueDB)
        // Then
        XCTAssertEqual(issue.route, "1")
        XCTAssertEqual(issue.name, "Sara")
        XCTAssertEqual(issue.surename, "Gutierrez")
        XCTAssertEqual(issue.email, "sagu@mailinator.com")
        XCTAssertEqual(issue.timestamp, 123)
        XCTAssertEqual(issue.report, "blah, blah")
        XCTAssertEqual(issue.phone, "123456789")

    }

    func test_initializerWhenIssueVM() {
        // Given
        let issueVM = IssueVM(route: "1",
                              name: "Leandro",
                              surename: "Fornés",
                              email: "lefe@gmail.com",
                              timestamp: Date(timeIntervalSince1970: 123.0),
                              report: "Blah blah",
                              phone: "123456789")
        // When
        let issue = Issue(issueVM: issueVM)
        // Then
        XCTAssertEqual(issue.route, "1")
        XCTAssertEqual(issue.name, "Leandro")
        XCTAssertEqual(issue.surename, "Fornés")
        XCTAssertEqual(issue.email, "lefe@gmail.com")
        XCTAssertEqual(issue.timestamp, 123)
        XCTAssertEqual(issue.report, "Blah blah")
        XCTAssertEqual(issue.phone, "123456789")
    }
}
