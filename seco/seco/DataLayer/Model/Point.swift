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
    
    // MARK: - Constructor/initializer
       init(latitude: Double,
            longitude: Double) {
           self.latitude = latitude
           self.longitude = longitude
       }

       init(pointAPI: PointAPI) {
           self.init(latitude: pointAPI.latitude,
                     longitude: pointAPI.longitude)
       }
}

extension Point: Equatable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
