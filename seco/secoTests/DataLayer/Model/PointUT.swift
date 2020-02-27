//
//  PointUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class PointUT: XCTestCase {

    func test_initializerWhenRouteAPI() {
        // Given
        let pointAPI = PointAPI(latitude: 1.2345, longitude: 6.789)
        // When
        let point = Point(pointAPI: pointAPI)
        // Then
        XCTAssertEqual(point.latitude, 1.2345)
        XCTAssertEqual(point.longitude,  6.789)
    }

}
