//
//  StopPointAPI.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct StopPointAPI: Codable {
    let stopTime: String
    let paid: Bool
    let address: String
    let tripID: Int
    let userName: String
    let point: PointAPI
    let price: Double

    enum CodingKeys: String, CodingKey {
        case stopTime, paid, address
        case tripID = "tripId"
        case userName, point, price
    }
}
