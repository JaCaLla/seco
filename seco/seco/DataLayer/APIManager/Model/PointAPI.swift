//
//  PointAPI.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

// MARK: - Point
struct PointAPI: Codable {
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "_latitude"
        case longitude = "_longitude"
    }
}

extension PointAPI: Equatable {
    static func == (lhs: PointAPI, rhs: PointAPI) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
