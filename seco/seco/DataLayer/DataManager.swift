//
//  DataManager.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func getAllRoutes(onComplete: @escaping (Swift.Result<[Route], Error>) -> Void)
    func getStop(stopId: Int, onComplete: @escaping (Swift.Result<StopPoint, Error>) -> Void)
}

final class DataManager {

    static let shared:DataManager = DataManager()

    // MARK: - Injected attributes
    private var injectedAPIManager:APIManagerProtocol = APIManager()


    // MARK: - Initializers
    init(apiManager:APIManagerProtocol = APIManager()) {

        self.injectedAPIManager = apiManager
    }
}

extension DataManager: DataManagerProtocol {
    func getStop(stopId: Int, onComplete: @escaping (Result<StopPoint, Error>) -> Void) {
        injectedAPIManager.getStop(stopId: stopId, onComplete: { result in
            switch result {
                case .success(let stopPointAPI): onComplete(.success(StopPoint(stopPointAPI: stopPointAPI)))
                case .failure(let error): onComplete(.failure(error))
            }
        })
    }
    
    // MARK: - DataManagerProtocol
    func getAllRoutes(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void) {
        injectedAPIManager.getAllRoutes(onComplete: { result in
            switch result {
            case .success(let routesAPI): onComplete(.success(routesAPI.map{ Route(routeAPI: $0) }))
            case .failure(let error): onComplete(.failure(error))
            }
        })
    }

}
