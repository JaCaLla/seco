//
//  DataManagerMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class DataManagerMock: DataManagerProtocol {
    
    func getStop(stopId: Int, onComplete: @escaping (Result<StopPoint, Error>) -> Void) {
        let stopPoint = StopPoint(stopTime: "2018-12-18T09:00:00.000Z",
                                  paid: false,
                                  userName: "Manuel Gomez")
        onComplete(.success(stopPoint))
    }
    

    func getAllRoutes(onComplete: @escaping (Result<([Route]), Error>) -> Void) {
        let routes = [Route(driverName: "Alberto Morales",
                            originAddress: "Barcelona",
                            destinationAddress: "Martorell",
                            startTime: "2018-12-18T08:00:00.000Z",
                            endTime: "2018-12-18T09:00:00.000Z",
                            points: []),
                      Route(driverName: "Julian Valdivia",
                            originAddress: "La Junquera",
                            destinationAddress: "Lleida",
                            startTime: "2018-12-18T18:00:00.000Z",
                            endTime: "2018-12-18T19:00:00.000Z",
                            points: []),
        ]

        onComplete(.success(routes))
    }
}
