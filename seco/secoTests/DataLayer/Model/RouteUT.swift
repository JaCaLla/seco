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
        let stopsAPI = [Stop(point: PointAPI(latitude: 1.111, longitude: 2.2222), id: 12),
                        Stop(point: PointAPI(latitude: 3.333, longitude: 4.4444), id: 34),
                        Stop(point: PointAPI(latitude: 5.555, longitude: 6.6666), id: 56)
        ]

        let routeAPI = RouteAPI(status: "ongoing",
                                origin: OriginDestinationAPI(address: "Barcelona", point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                stops: stopsAPI,
                                destination: OriginDestinationAPI(address: "Martorell", point: PointAPI(latitude: 45.38074, longitude: 4.18594)),
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
        guard route.points.count == 5 else {
            XCTFail()
            return
        }
        XCTAssertEqual(route.points[0], Point(latitude: 41.38074, longitude: 2.18594))
        XCTAssertEqual(route.points[1], Point(latitude: 1.111, longitude: 2.2222, stopId: 12))
        XCTAssertEqual(route.points[2], Point(latitude: 3.333, longitude: 4.4444, stopId: 34))
        XCTAssertEqual(route.points[3], Point(latitude: 5.555, longitude: 6.6666, stopId: 56))
        XCTAssertEqual(route.points[4], Point(latitude: 45.38074, longitude: 4.18594))
        
    }

}
