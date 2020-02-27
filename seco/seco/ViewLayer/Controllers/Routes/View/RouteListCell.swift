//
//  RouteListCell.swift
//  seco
//
//  Created by Javier Calatrava on 27/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit

class RouteListCell: UITableViewCell {

    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var lblStartEnd: UILabel!
    @IBOutlet weak var lblOriginDestination: UILabel!
    
    
    // MARK: - Public methods
    func set(routeVM: RouteVM) {
        lblOriginDestination.text  = routeVM.originDestination
        lblStartEnd.text = routeVM.startEnd
        lblDriverName.text = routeVM.driverName
    }

}
