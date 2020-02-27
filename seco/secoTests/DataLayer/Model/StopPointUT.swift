//
//  StopPointUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class StopPointUT: XCTestCase {

    func test_initializerWhenRouteAPI() {
        // Given
        let stopPointAPI = StopPointAPI(stopTime: "2018-12-18T09:00:00.000Z",
                                        paid: true,
                                        address: "",
                                        tripID: 3,
                                        userName: "Manuel Gomez",
                                        pointAPI: PointAPI(latitude: 12.23, longitude: 4.32),
                                        price: 12.22)
        // When
        let stopPoint = StopPoint(stopPointAPI: stopPointAPI)
        // Then
        XCTAssertEqual(stopPoint.stopTime, "2018-12-18T09:00:00.000Z")
        XCTAssertEqual(stopPoint.paid, true)
        XCTAssertEqual(stopPoint.userName, "Manuel Gomez")
    }
}
