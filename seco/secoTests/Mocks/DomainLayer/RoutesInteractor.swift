//
//  RoutesInteractor.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class RoutesInteractorMock: RoutesInteractorProtocol {
    
    var getAllRoutesCalled: Bool = false
    var getStopCalled: Bool = false

    var routes: [Route]?
    var stopPoint: StopPoint?

    func getAllRoutes(onComplete: @escaping (Result<([Route]), Error>) -> Void) {
        getAllRoutesCalled = true

        guard let uwpRoutes = routes else {
            let error = NSError(domain: "Domain",
                                code: ResponseCodeAPI.testForcedError.rawValue,
                                userInfo: [:])
            onComplete(.failure(error))
            return
        }

        onComplete(.success(uwpRoutes))
    }
    
    func getStop(stopId: Int, onComplete: @escaping (Result<StopPoint, Error>) -> Void) {
        getStopCalled = true
        
        guard let uwpStopPoint = stopPoint else {
            let error = NSError(domain: "Domain",
                                code: ResponseCodeAPI.testForcedError.rawValue,
                                userInfo: [:])
            onComplete(.failure(error))
            return
        }

        onComplete(.success(uwpStopPoint))
    }

}

/*
let routes:[Route] = [ Route(driverName: "Alberto Morales",
                             originAddress: "Barcelona",
                             destinationAddress: "Martorell",
                             startTime: "2018-12-18T08:00:00.000Z",
                             endTime: "2018-12-18T09:00:00.000Z")
]
*/
