//
//  RouteAPI.swift
//  seco
//
//  Created by Javier Calatrava on 24/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct RouteAPI: Codable {
    let status: String
    let origin: OriginDestinationAPI
    let stops: [Stop]
    let destination: OriginDestinationAPI
    let endTime, startTime, description, driverName: String
    let route: String

    enum CodingKeys: String, CodingKey {
        case status, origin, stops, destination, endTime, startTime, description, driverName, route
    }
    
}

// MARK: - Destination
struct OriginDestinationAPI: Codable {
    let address: String
    let point: PointAPI
}

// MARK: - Stop
struct Stop: Codable {
    let point: PointAPI?
    let id: Int?
}

