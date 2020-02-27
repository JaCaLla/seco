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

    func getStop(stopId: Int, onComplete: @escaping (Result<StopPointAPI, Error>) -> Void) {
        let stopPointAPI = StopPointAPI(stopTime: "2018-12-18T09:00:00.000Z",
                                        paid: true,
                                        address: "",
                                        tripID: 3,
                                        userName: "Manuel Gomez",
                                        pointAPI: PointAPI(latitude: 12.23, longitude: 4.32),
                                        price: 12.22)
        
        onComplete(.success(stopPointAPI))
    }

    func getAllRoutes(onComplete: @escaping (Result<([RouteAPI]), Error>) -> Void) {

        let routeAPI = RouteAPI(status: "ongoing",
                                origin: OriginDestinationAPI(address: "Barcelona",
                                                             point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                stops: [],
                                destination: OriginDestinationAPI(address: "Martorell",
                                                                  point: PointAPI(latitude: 41.38074, longitude: 2.18594)),
                                endTime: "2018-12-18T09:00:00.000Z",
                                startTime: "2018-12-18T08:00:00.000Z",
                                description: "Barcelona a Martorell",
                                driverName: "Alberto Morales",
                                route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@")

        onComplete(.success([routeAPI]))
    }


}
