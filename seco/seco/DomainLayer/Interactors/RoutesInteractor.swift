//
//  RoutesInteractor.swift
//  seco
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

// MARK: - Protocol
protocol RoutesInteractorProtocol {
    func getAllRoutes2(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void)
}

class RoutesInteractor {
    // MARK: - Private attributes
    var dataManager: DataManagerProtocol = DataManager()
    
    // MARK: - Initializer/Constructor
    init(dataManager: DataManagerProtocol = DataManager()) {
        self.dataManager = dataManager
    }
}


// MARK: - RoutesInteractorProtocol
extension RoutesInteractor: RoutesInteractorProtocol {
    
    func getAllRoutes2(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void) {
        dataManager.getAllRoutes2(onComplete: onComplete)
    }
}
