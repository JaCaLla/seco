//
//  RouteList.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit

class RouteList: UITableView {
    
    // MARK: - Callbacks
    var onSelect: (RouteVM) -> Void = { _ in /* Default empty block */}
    
    // MARK: - Private attributes
    private var routesVM:[RouteVM] = []

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
   // MARK: - Public methods
    func set(routes: [RouteVM]) {
        self.routesVM = routes
        self.reloadData()
    }

    // MARK: - Private methdos
    func setupView() {
        dataSource = self
        delegate = self
        self.tableFooterView = UIView()
    }
}

extension RouteList: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let routeListCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.routeListCell.identifier, for: indexPath) as? RouteListCell else {
            return UITableViewCell()
        }
        routeListCell.set(routeVM: self.routesVM[indexPath.row])
        return routeListCell
    }
}

extension RouteList: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onSelect(self.routesVM[indexPath.row])
    }
}
