//
//  APIManagerMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class APIManagerMock: APIManagerProtocol {
    func getAllRoutes(onSucceed: @escaping (([RouteAPI]) -> Void), onFailed: @escaping ((ResponseCodeAPI) -> Void)) {

    }

    func getAllRoutes2(onComplete: @escaping (Result<([RouteAPI]), Error>) -> Void) {

        let routeAPI = RouteAPI(status: "ongoing",
                                origin: Destination(address: "Barcelona",
                                                    point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                stops: [],
                                destination: Destination(address: "Martorell",
                                                         point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                endTime: "2018-12-18T09:00:00.000Z",
                                startTime: "2018-12-18T08:00:00.000Z",
                                description: "Barcelona a Martorell",
                                driverName: "Alberto Morales",
                                route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")

        onComplete(.success([routeAPI]))
    }


}
