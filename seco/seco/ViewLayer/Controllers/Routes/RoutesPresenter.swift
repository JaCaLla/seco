//
//  RoutesPresenter.swift
//  seco
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

protocol RoutesPresenterProtocol {
    func set(routesVC: RoutesVCProtocol)
    func fetchRoutes()
    func fetchStopPoint(stopId: Int)
}

class RoutesPresenter {

    // MARK: - Private attributes
    private var interactor: RoutesInteractorProtocol = RoutesInteractor()
    private weak var view: RoutesVCProtocol?

    // MARK: - Initializer/Constructor
    init(interactor: RoutesInteractorProtocol = RoutesInteractor()) {
        self.interactor = interactor
    }
}

extension RoutesPresenter: RoutesPresenterProtocol {

    func set(routesVC: RoutesVCProtocol) {
        self.view = routesVC
    }

    func fetchRoutes() {
        self.view?.presentActivityIndicator()
        self.interactor.getAllRoutes(onComplete: { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.removeActivityIndicator()
                switch result {
                case .success(let routes):
                    let routesVM: [RouteVM] = routes.map({ RouteVM(route: $0) })
                    self?.view?.presentFetchedRoutes(routesVM: routesVM)
                case .failure(let error):
                    self?.view?.present(error: error)
                }
            }
        })
    }
    
    func fetchStopPoint(stopId: Int) {
        self.view?.presentActivityIndicator()
        self.interactor.getStop(stopId: stopId, onComplete: { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.removeActivityIndicator()
                switch result {
                case .success(let stopPoint):
                    self?.view?.presentPopUp(stopPointVM: StopPointVM(stopPoint: stopPoint))
                case .failure( let error):
                    self?.view?.present(error: error)
                }
            }
        })
    }
}
