//
//  RouteMap.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit
import MapKit

class RouteMap: MKMapView {


    // MARK: - Public methods
     func set(routeVM: RouteVM) {
        self.removeAnnotations(self.annotations)
        self.addAnnotations(routeVM.annotations)
        self.fitMapViewToAnnotaionList(annotations: self.annotations)
     }
    
    // MARK: - Private methods
    private func fitMapViewToAnnotaionList(annotations: [MKAnnotation]) -> Void {
        
        let mapEdgePadding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var zoomRect:MKMapRect = MKMapRect.null

        annotations.forEach({
            let annotation = $0
            let aPoint:MKMapPoint = MKMapPoint(annotation.coordinate)
            let rect:MKMapRect = MKMapRect(x: aPoint.x, y: aPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.isNull ? rect : zoomRect.union(rect)
        })

        self.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
    }
}
