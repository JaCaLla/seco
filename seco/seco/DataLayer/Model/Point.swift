//
//  Point.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct Point: Codable {
    let latitude, longitude: Double
    let stopId: Int?

    // MARK: - Constructor/initializer
    init(latitude: Double,
         longitude: Double,
         stopId: Int? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.stopId = stopId
    }

    init(pointAPI: PointAPI, stopId: Int? = nil) {
        self.init(latitude: pointAPI.latitude,
                  longitude: pointAPI.longitude,
                  stopId: stopId)
    }
}

extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        if let uwpLhsStopId  = lhs.stopId,
            let uwpRhsStopId  = rhs.stopId {
            return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && uwpLhsStopId == uwpRhsStopId
        } else if lhs.stopId == nil,
            rhs.stopId == nil  {
             return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
        } else {
            return false
        }
    }
}
