//
//  StopPoint.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct StopPoint {
   let stopTime: String
    let paid: Bool
    let userName: String
    
    init(stopTime: String,
         paid: Bool,
         userName: String) {
        self.stopTime = stopTime
        self.paid = paid
        self.userName = userName
    }
    
    init(stopPointAPI: StopPointAPI) {
        self.init(stopTime: stopPointAPI.stopTime,
                  paid: stopPointAPI.paid,
                  userName: stopPointAPI.userName)
    }
}
