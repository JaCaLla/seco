//
//  RoutesVCMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco
class RoutesVCMock: RoutesVCProtocol {

    var presentActivityIndicatorCalled: Bool = false
    var removeActivityIndicatorCalled: Bool = false
    var presentFetchedRoutesCalled: Bool = false
    var presentCalled: Bool = false
    
    func presentActivityIndicator() {
        presentActivityIndicatorCalled = true
    }
    
    func removeActivityIndicator() {
        removeActivityIndicatorCalled = true
    }

    func presentFetchedRoutes(routesVM: [RouteVM]) {
        presentFetchedRoutesCalled = true
    }
    
    func present(error: Error) {
        presentCalled = true
    }
    
    
}
