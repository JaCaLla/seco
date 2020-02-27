//
//  RouteVMUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class RouteVMUT: XCTestCase {

    func test_initializer() {
        // Given
        let route = Route(driverName: "Alberto Morales",
        originAddress: "Barcelona",
        destinationAddress: "Martorell",
        startTime: "2018-12-18T08:00:00.000Z",
        endTime: "2018-12-18T09:00:00.000Z",
        points: [])
        // When
        let routeVM = RouteVM(route: route)
        //Then
        XCTAssertEqual(routeVM.driverName, "Alberto Morales")
        XCTAssertEqual(routeVM.originDestination, "Barcelona - Martorell")
        XCTAssertEqual(routeVM.startEnd, "2018-12-18T08:00:00.000Z - 2018-12-18T09:00:00.000Z")
        
    }

}
