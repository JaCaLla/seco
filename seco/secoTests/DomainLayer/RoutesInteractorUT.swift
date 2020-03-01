//
//  RoutesInteractorUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco

class RoutesInteractorUT: XCTestCase {

    // MARK: - Test variables.
    var sut: RoutesInteractor!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let dataManagerMock: DataManagerProtocol = DataManagerMock()
        sut = RoutesInteractor(dataManager: dataManagerMock)
        DBManager.shared.reset()
    }

    func test_getAllRoutes() {
        let asyncExpectation = expectation(description: "\(#function)")

        sut.getAllRoutes(onComplete: { result in
            switch result {
            case .success(let routes):
                XCTAssertEqual(routes.count, 2)
                guard let first = routes.first,
                    let last = routes.last else {
                        XCTFail()
                        asyncExpectation.fulfill()
                        return
                }
                XCTAssertEqual(first.driverName, "Alberto Morales")
                XCTAssertEqual(first.originAddress, "Barcelona")
                XCTAssertEqual(first.destinationAddress, "Martorell")
                XCTAssertEqual(first.startTime, "2018-12-18T08:00:00.000Z")
                XCTAssertEqual(first.endTime, "2018-12-18T09:00:00.000Z")

                XCTAssertEqual(last.driverName, "Julian Valdivia")
                XCTAssertEqual(last.originAddress, "La Junquera")
                XCTAssertEqual(last.destinationAddress, "Lleida")
                XCTAssertEqual(last.startTime, "2018-12-18T18:00:00.000Z")
                XCTAssertEqual(last.endTime, "2018-12-18T19:00:00.000Z")
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
                XCTAssertEqual(stopPoint.paid, false)
                XCTAssertEqual(stopPoint.userName, "Manuel Gomez")
            case .failure:
                XCTFail()
            }
            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func test_getIssue() {
        // Given
        // When
        let asyncExpectation = expectation(description: "\(#function)")
        sut.getIssue(route: "asdf",
                     onComplete:{ issue in
            guard let uwpIssue = issue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            XCTAssertEqual(uwpIssue.route, "asdf")
            XCTAssertEqual(uwpIssue.name, "Pepito")
            XCTAssertEqual(uwpIssue.surename, "Grillo")
            XCTAssertEqual(uwpIssue.email, "pegri@mailinator.com")

            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func test_createIssue() {
        // Given
        let issue = Issue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                          name: "Sara",
                          surename: "Gutierrez",
                          email: "sagu@mailinator.com", timestamp: 123, report:"blah, blah", phone: "123456789")

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
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

}
