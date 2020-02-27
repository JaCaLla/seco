//
//  StopPointVM.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

struct StopPointVM {
    var title: String
    var message: String
    
    init(stopPoint: StopPoint) {
        title = stopPoint.paid ? R.string.localizable.routes_paid.key.localized : R.string.localizable.routes_not_paid.key.localized
        message = "\(stopPoint.userName) - \(stopPoint.stopTime)"
    }
}
