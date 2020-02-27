//
//  RoutesPresenterMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class RoutesPresenterMock: RoutesPresenterProtocol {
    
    var setRoutesCalled: Bool = false
    var fetchRoutesCalled: Bool = false
    
    func set(routesVC: RoutesVCProtocol) {
        setRoutesCalled = true
    }
    
    func fetchRoutes() {
        fetchRoutesCalled = true
    }
    
    
}