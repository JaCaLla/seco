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
    @IBOutlet weak var vewAccessory: UIView!

    // MARK: - Callbacks
    var onGetIssue: () -> Void = { /* Default empty block */ }

    // MARK: - Private attributes
    private var routeVM: RouteVM?

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        vewAccessory.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }

    // MARK: - Public methods
    func set(routeVM: RouteVM) {
        self.routeVM = routeVM
        lblOriginDestination.text = routeVM.originDestination
        lblStartEnd.text = routeVM.startEnd
        lblDriverName.text = routeVM.driverName
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    }

    // MARK : - Target methods
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        onGetIssue()
    }

}
