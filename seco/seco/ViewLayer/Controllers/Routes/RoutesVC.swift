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
            guard let weakSelf = self else { return }
            weakSelf.routeMap.set(routeVM: routeVM)
        }
    }
}

// MARK: - RoutesVCProtocol
extension RoutesVC: RoutesVCProtocol {
    
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