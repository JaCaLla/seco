//
//  DataManager.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
//    func rates(onComplete: @escaping (DataManagerResponse) -> () )
//    func transactions(sku:String?,onComplete: @escaping (DataManagerResponse) -> () )
//     func add(rate:Rate)
    func getAllRoutes2(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void)
}

//enum DataManagerResponse {
//    case rates([Rate])
//    case transactions([Transaction])
//    case networkError
//}

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
    // MARK: - DataManagerProtocol
    func getAllRoutes2(onComplete: @escaping (Swift.Result<([Route]), Error>) -> Void) {
        injectedAPIManager.getAllRoutes2(onComplete: { result in
            switch result {
            case .success(let routesAPI): onComplete(.success(routesAPI.map{ Route(routeAPI: $0) }))
            case .failure(let error): onComplete(.failure(error))
            }
        })
    }
//    func add(rate:Rate) {
//        guard var cachedRates = self.cachedRates else {
//            return
//        }
//        if cachedRates.filter({ $0 == rate }).first == nil {
//            cachedRates.append(rate)
//            self.cachedRates = cachedRates
//        }
//
//    }
//
//    func rates(onComplete: @escaping (DataManagerResponse) -> () ) {
//        if let cachedRates = self.cachedRates {
//            onComplete(.rates(cachedRates))
//            return
//        }
//        self.injectedAPIManager.rates(onSucceed: { [weak self] ratesAPI in
//            guard let weakSelf = self else { return }
//              let rates = ratesAPI.compactMap({ Rate(rateAPI: $0)})
//              weakSelf.cachedRates = rates
//               onComplete(.rates(rates))
//            }, onFailed:  { responseCodeAPI in
//                onComplete(.networkError)
//        })
//    }
//
//    func transactions(sku:String?,onComplete: @escaping (DataManagerResponse) -> () ) {
//        if let cachedTransactions = self.cachedTransactions {
//            if let uwpSku = sku {
//                onComplete(.transactions(cachedTransactions.filter({ $0.sku == uwpSku })))
//            } else {
//                 onComplete(.transactions(cachedTransactions))
//            }
//
//            return
//        }
//        self.injectedAPIManager.transactions(onSucceed: { allTransactionsAPI in
//            let transactions = allTransactionsAPI.compactMap({ Transaction(transactionAPI: $0) })
//            self.cachedTransactions = transactions
//            guard let uwpSku = sku else {
//                 onComplete(.transactions(allTransactionsAPI.compactMap({ Transaction(transactionAPI: $0) })))
//                return
//            }
//            onComplete(.transactions(allTransactionsAPI.filter({ $0.sku == uwpSku }).compactMap({ Transaction(transactionAPI: $0) })))
//
//        }, onFailed:  { responseCodeAPI in
//            onComplete(.networkError)
//        })
//    }
}


//// MARK: - Resetable extension
//extension DataManager: Resetable {
//    func reset() {
//        self.injectedAPIManager.reset()
////        self.cachedRates = nil
////        self.cachedTransactions = nil
//    }
//}
