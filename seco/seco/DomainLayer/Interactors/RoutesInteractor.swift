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
    func getAllRoutes(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void)
    func getStop(stopId: Int, onComplete: @escaping (Swift.Result<StopPoint, Error>) -> Void)
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
    
    func getAllRoutes(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void) {
        dataManager.getAllRoutes(onComplete: onComplete)
    }
    
    func getStop(stopId: Int, onComplete: @escaping (Result<StopPoint, Error>) -> Void) {
        dataManager.getStop(stopId: stopId, onComplete: onComplete)
    }
}
