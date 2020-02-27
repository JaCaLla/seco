//
//  Route.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct Route {
    let driverName: String
    let originAddress: String
    let destinationAddress: String
    let endTime: String
    let startTime: String

    // MARK: - Constructor/initializer
    init(driverName: String,
         originAddress: String,
         destinationAddress: String,
         startTime: String,
         endTime: String) {
        self.driverName = driverName
        self.originAddress = originAddress
        self.destinationAddress = destinationAddress
        self.endTime = endTime
        self.startTime = startTime
    }

    init(routeAPI: RouteAPI) {
        self.init(driverName: routeAPI.driverName,
                  originAddress: routeAPI.origin.address,
                  destinationAddress: routeAPI.destination.address,
                  startTime: routeAPI.startTime,
                  endTime: routeAPI.endTime)
    }
}
