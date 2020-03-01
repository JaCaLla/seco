//
//  IssueDBUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class IssueDBUT: XCTestCase {


    func test_consturctor() {
        // Given
        // When
        let issueDB = IssueDB(route: "a",
                              name: "as",
                              surename: "df",
                              email: "asdf@gmail.com",
                              timestamp: 123,
                              report:"blah, blah",
                              phone: "123456789")
        // Then
        XCTAssertEqual(issueDB.route, "a")
        XCTAssertEqual(issueDB.name, "as")
        XCTAssertEqual(issueDB.surename, "df")
        XCTAssertEqual(issueDB.email, "asdf@gmail.com")
        XCTAssertEqual(issueDB.timestamp, 123)
        XCTAssertEqual(issueDB.report, "blah, blah")
        XCTAssertEqual(issueDB.phone, "123456789")
        
    }
    
    func test_constructorWhenIssue() {
        // Given
        // When
        let issue = Issue(route: "a",
                          name: "as",
                          surename: "df",
                          email: "asdf@gmail.com",
                          timestamp: 123,
                          report:"blah, blah",
                          phone: "123456789")
        let issueDB = IssueDB(issue: issue)
        // Then
        XCTAssertEqual(issueDB.route, "a")
        XCTAssertEqual(issueDB.name, "as")
        XCTAssertEqual(issueDB.surename, "df")
        XCTAssertEqual(issueDB.email, "asdf@gmail.com")
        XCTAssertEqual(issueDB.timestamp, 123)
        XCTAssertEqual(issueDB.report, "blah, blah")
        XCTAssertEqual(issueDB.phone, "123456789")
        
    }

}
