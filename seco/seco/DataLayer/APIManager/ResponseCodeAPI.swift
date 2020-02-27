//
//  ResponseCodeAPI.swift
//  seco
//
//  Created by Javier Calatrava on 24/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

enum ResponseCodeAPI : Int {
    case missingResponseResultValue = -5
    case badFormedJSONModel = -3
    case responseValidationFailed = -1
    case connectivityError = -4
    case testForcedError = -2
}
