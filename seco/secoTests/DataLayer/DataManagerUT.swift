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
}
