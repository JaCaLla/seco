//
//  RouteVM.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct RouteVM {
    var driverName: String
    var startEnd: String
    var originDestination: String
    
    // MARK: - Constructor/Initializer
    init(route: Route) {
        self.driverName = route.driverName
        self.startEnd = "\(route.startTime) - \(route.endTime)"
        self.originDestination = "\(route.originAddress) - \(route.destinationAddress)"
    }
}
