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
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getAllRoutes() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let asyncExpectation = expectation(description: "\(#function)")

        sut.getAllRoutes2(onComplete: { result in
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

}
