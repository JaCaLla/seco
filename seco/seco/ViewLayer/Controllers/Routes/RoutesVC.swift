//
//  RoutesVC.swift
//  seco
//
//  Created by Javier Calatrava on 25/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol RoutesVCProtocol: AnyObject {
    func presentActivityIndicator()
    func removeActivityIndicator()
    func presentFetchedRoutes(routesVM: [RouteVM])
    func presentPopUp(stopPointVM: StopPointVM)
    func present(error: Error)
}

class RoutesVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var routeList: RouteList!
    @IBOutlet weak var routeMap: RouteMap!
    
    // MARK: - Private attributes
    var presenter: RoutesPresenterProtocol = RoutesPresenter()
    
    // MARK: - Constructor/Initializer
    
    public static func instantiate(presenter: RoutesPresenterProtocol = RoutesPresenter()) -> RoutesVC {
        let storyboard = UIStoryboard(name: R.storyboard.main.name, bundle: nil)
        guard let routesVC = storyboard.instantiateViewController(withIdentifier: String(describing: RoutesVC.self)) as? RoutesVC else {
                return RoutesVC()
        }
        routesVC.presenter = presenter
        presenter.set(routesVC: routesVC)
        return routesVC
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         presenter.fetchRoutes()
    }
    
    // MARK: - Private methods
    func setupViewController() {
        routeList.onSelect = { [weak self] routeVM in
            self?.routeMap.set(routeVM: routeVM)
        }
        routeMap.onSelectedStop = { [weak self] stopId in
            self?.presenter.fetchStopPoint(stopId: stopId)
        }
    }
}

// MARK: - RoutesVCProtocol
extension RoutesVC: RoutesVCProtocol {
    func presentPopUp(stopPointVM: StopPointVM) {
        
        let alert = UIAlertController(title: stopPointVM.title,
                                      message: stopPointVM.message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alert_continue.key.localized,
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func presentActivityIndicator() {
        SVProgressHUD.setContainerView(self.view)
        SVProgressHUD.show()
    }
    
    func removeActivityIndicator() {
        SVProgressHUD.dismiss()
    }
    
    func presentFetchedRoutes(routesVM: [RouteVM]) {
        routeList.set(routes: routesVM)
    }
    
    func present(error: Error) {
        // TODO
    }
}
