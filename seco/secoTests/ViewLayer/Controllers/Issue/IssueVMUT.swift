//
//  IssueVMUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class IssueVMUT: XCTestCase {

    func test_initializer() {

        // Given
        let issue: Issue = Issue(route: "as", name: "Gustavo", surename: "Fernandez", email: "gufe@gmail.com", timestamp: 123.0, report: "blah, blah", phone: "123456789")
        // When
        let issueVM = IssueVM(issue: issue)
        //Then
        XCTAssertEqual(issueVM.route, "as")
        XCTAssertEqual(issueVM.name, "Gustavo")
        XCTAssertEqual(issueVM.surename, "Fernandez")
        XCTAssertEqual(issueVM.email, "gufe@gmail.com")
        XCTAssertEqual(issueVM.timestamp, Date(timeIntervalSince1970: 123.0))
        XCTAssertEqual(issueVM.report, "blah, blah")
         XCTAssertEqual(issueVM.phone, "123456789")
    }
}
