//
//  RouteUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco

class RouteUT: XCTestCase {

    func test_initializerWhenRouteAPI() {
        // Given
        let routeAPI = RouteAPI(status: "ongoing",
                                origin: Destination(address: "Barcelona", point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                stops: [],
                                destination: Destination(address: "Martorell", point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                endTime: "2018-12-18T09:00:00.000Z",
                                startTime: "2018-12-18T08:00:00.000Z",
                                description: "Barcelona a Martorell",
                                driverName: "Alberto Morales",
                                route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")
        // When
        let route = Route(routeAPI: routeAPI)
        // Then
        XCTAssertEqual(route.driverName, "Alberto Morales")
        XCTAssertEqual(route.originAddress, "Barcelona")
        XCTAssertEqual(route.destinationAddress, "Martorell")
        XCTAssertEqual(route.startTime, "2018-12-18T08:00:00.000Z")
        XCTAssertEqual(route.endTime, "2018-12-18T09:00:00.000Z")
    }

}
