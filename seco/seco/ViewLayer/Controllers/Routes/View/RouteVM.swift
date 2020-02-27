//
//  RouteVM.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
import MapKit

struct RouteVM {
    var driverName: String
    var startEnd: String
    var originDestination: String
    var annotations:[MKPointAnnotation]
    
    // MARK: - Constructor/Initializer
    init(route: Route) {
        self.driverName = route.driverName
        self.startEnd = "\(route.startTime) - \(route.endTime)"
        self.originDestination = "\(route.originAddress) - \(route.destinationAddress)"
        self.annotations = route.points.map({
            let location = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            let CLLCoordType = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                      longitude: location.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            return anno
        })
    }
}

