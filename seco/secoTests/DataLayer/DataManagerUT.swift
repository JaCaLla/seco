//
//  DataManagerUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class DataManagerUT: XCTestCase {

    // MARK: - Test variables.
    var sut: DataManager!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let apiManager: APIManagerProtocol = APIManagerMock()
        sut = DataManager(apiManager: apiManager)
        DBManager.shared.reset()
    }

    func test_getAllRoutes() {

        let asyncExpectation = expectation(description: "\(#function)")

        sut.getAllRoutes(onComplete: { result in
            switch result {
            case .success(let routes):
                XCTAssertEqual(routes.count, 1)
                guard let first = routes.first else {
                    XCTFail()
                    asyncExpectation.fulfill()
                    return
                }
                XCTAssertEqual(first.route, "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")
                XCTAssertEqual(first.driverName, "Alberto Morales")
                XCTAssertEqual(first.originAddress, "Barcelona")
                XCTAssertEqual(first.destinationAddress, "Martorell")
                XCTAssertEqual(first.startTime, "2018-12-18T08:00:00.000Z")
                XCTAssertEqual(first.endTime, "2018-12-18T09:00:00.000Z")
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func test_getStopPoint() {
        let asyncExpectation = expectation(description: "\(#function)")

        sut.getStop(stopId: 1, onComplete: { result in
            switch result {
            case .success(let stopPoint):
                XCTAssertEqual(stopPoint.stopTime, "2018-12-18T09:00:00.000Z")
                XCTAssertEqual(stopPoint.paid, true)
                XCTAssertEqual(stopPoint.userName, "Manuel Gomez")
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func test_getRouteWithIssue() {
        // Given
        let issueDB = IssueDB(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                              name: "Sara",
                              surename: "Gutierrez",
                              email: "sagu@mailinator.com",
                              timestamp: 123,
                              report: "blah, blah", phone: "123456789")
        DBManager.shared.create(issueDB: issueDB)
        let asyncExpectation = expectation(description: "\(#function)")

        sut.getAllRoutes(onComplete: { result in
            switch result {
            case .success(let routes):
                XCTAssertEqual(routes.count, 1)
                guard let first = routes.first else {
                    XCTFail()
                    asyncExpectation.fulfill()
                    return
                }
                XCTAssertEqual(first.hasIssue, true)
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func test_getRouteWithoutIssue() {
        // Given
        let asyncExpectation = expectation(description: "\(#function)")
        // When
        sut.getAllRoutes(onComplete: { result in
            switch result {
            case .success(let routes):
                XCTAssertEqual(routes.count, 1)
                guard let first = routes.first else {
                    XCTFail()
                    asyncExpectation.fulfill()
                    return
                }
                // Then
                XCTAssertEqual(first.hasIssue, false)
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }



    func test_fetchIssueWhenExists() {
        // Given
        let issueDB = IssueDB(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                              name: "Sara",
                              surename: "Gutierrez",
                              email: "sagu@mailinator.com",
                              timestamp: 123,
                              report: "blah, blah", phone: "123456789")
        DBManager.shared.create(issueDB: issueDB)
        let asyncExpectation = expectation(description: "\(#function)")
        // When
        sut.getIssue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                     onComplete: { issue in
                         guard let uwpIssue = issue else {
                             XCTFail()
                             asyncExpectation.fulfill()
                             return
                         }
                         XCTAssertEqual(uwpIssue.route, "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")
                         XCTAssertEqual(uwpIssue.name, "Sara")
                         XCTAssertEqual(uwpIssue.surename, "Gutierrez")
                         XCTAssertEqual(uwpIssue.email, "sagu@mailinator.com")
                         XCTAssertEqual(uwpIssue.timestamp, 123)
                         XCTAssertEqual(uwpIssue.report, "blah, blah")
                         XCTAssertEqual(uwpIssue.phone, "123456789")
                         asyncExpectation.fulfill()
                     })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func test_fetchIssueWhenDoesNotExists() {
        // Given
        let issueDB = IssueDB(route: "1",
                              name: "Sara",
                              surename: "Gutierrez",
                              email: "sagu@mailinator.com",
                              timestamp: 123,
                              report: "blah, blah", phone: "123456789")
        DBManager.shared.create(issueDB: issueDB)
        let asyncExpectation = expectation(description: "\(#function)")
        // When
        sut.getIssue(route: "2",
                     onComplete: { issue in
                         guard let uwpIssue = issue else {

                             asyncExpectation.fulfill()
                             return
                         }
                         XCTFail()

                         asyncExpectation.fulfill()
                     })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func test_createIssue() {
        // Given
        let issue = Issue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                          name: "Sara",
                          surename: "Gutierrez",
                          email: "sagu@mailinator.com",
                          timestamp: 123,
                          report: "blah, blah",
                          phone: "123456789")

        let asyncExpectation = expectation(description: "\(#function)")
        // When
        sut.create(issue: issue, onComplete: { [weak self] in
            // Then
            self?.sut.getIssue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                               onComplete: { issue in
                                   guard let uwpIssue = issue else {
                                       XCTFail()
                                       asyncExpectation.fulfill()
                                       return
                                   }
                                   XCTAssertEqual(uwpIssue.route, "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")
                                   XCTAssertEqual(uwpIssue.name, "Sara")
                                   XCTAssertEqual(uwpIssue.surename, "Gutierrez")
                                   XCTAssertEqual(uwpIssue.email, "sagu@mailinator.com")
                                   XCTAssertEqual(uwpIssue.timestamp, 123)
                                   XCTAssertEqual(uwpIssue.report, "blah, blah")
                                   XCTAssertEqual(uwpIssue.phone, "123456789")
                                   asyncExpectation.fulfill()
                               })
        })

        // asyncExpectation.fulfill()
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }


    func test_getIssuesCount() {
        // Given
        XCTAssertEqual(sut.getIssuesCount(), 0)
        // Given
        let issue = Issue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                          name: "Sara",
                          surename: "Gutierrez",
                          email: "sagu@mailinator.com",
                          timestamp: 123,
                          report: "blah, blah", phone: "123456789")

        let asyncExpectation = expectation(description: "\(#function)")
        // When
        sut.create(issue: issue, onComplete: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                asyncExpectation.fulfill()
                return

            }
            // Then
            XCTAssertEqual(weakSelf.sut.getIssuesCount(), 1)
            asyncExpectation.fulfill()
        })

        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
}
