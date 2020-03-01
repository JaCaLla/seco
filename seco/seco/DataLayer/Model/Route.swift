//
//  Route.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct Route {
    let route: String
    let driverName: String
    let originAddress: String
    let destinationAddress: String
    let endTime: String
    let startTime: String
    let points: [Point]
    let hasIssue: Bool

    // MARK: - Constructor/initializer
    init(route: String,
         driverName: String,
         originAddress: String,
         destinationAddress: String,
         startTime: String,
         endTime: String,
         points: [Point],
         hasIssue: Bool) {
        self.route = route
        self.driverName = driverName
        self.originAddress = originAddress
        self.destinationAddress = destinationAddress
        self.endTime = endTime
        self.startTime = startTime
        self.points = points
        self.hasIssue = hasIssue
    }

    init(routeAPI: RouteAPI, hasIssue: Bool) {
        var points: [Point] = []
        points.append(Point(pointAPI: routeAPI.origin.point))
        points.append(contentsOf: routeAPI.stops.compactMap({
            guard let uwpPoint = $0.point else { return nil}
            return Point(pointAPI: uwpPoint, stopId: $0.id)
        }))
        points.append(Point(pointAPI: routeAPI.destination.point))
        
        self.init(route: routeAPI.route,
                  driverName: routeAPI.driverName,
                  originAddress: routeAPI.origin.address,
                  destinationAddress: routeAPI.destination.address,
                  startTime: routeAPI.startTime,
                  endTime: routeAPI.endTime,
                  points: points,
                  hasIssue: hasIssue)
    }
}
