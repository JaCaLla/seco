//
//  MainFlowCoordinator.swift
//  vlng
//
//  Created by Javier Calatrava Llaveria on 21/05/2019.
//  Copyright © 2019 Javier Calatrava Llaveria. All rights reserved.
//

import Foundation
import UIKit

class MainFlowCoordinator {

    // MARK: - Singleton handler
    static let shared = MainFlowCoordinator()

    // MARK: - Private attributes
    private let navigationController = UINavigationController()


    private init() { /*This prevents others from using the default '()' initializer for this class. */ }

    // MARK: - Pulic methods
    func start() {
        return self.presentTransactionsList()
    }

    // MARK: - Private/Internal
    private func presentTransactionsList() {

        let routesVC = RoutesVC.instantiate()
        routesVC.onGetIssue = { [weak self] issue in
            self?.presentIssue(issue: issue)
        }
        routesVC.modalTransitionStyle = .crossDissolve
        guard let window = UIApplication.shared.keyWindowInConnectedScenes else { return }
        navigationController.viewControllers = [routesVC]
        window.rootViewController = navigationController
    }


    private func presentIssue(issue: Issue) {

        let issueVM: IssueVM = IssueVM(issue: issue)
        let issueVC = IssueVC.instantiate(issueVM: issueVM)
        issueVC.onDismiss = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.navigationController.popViewController(animated: true)
        }

        navigationController.pushViewController(issueVC, animated: true)
    }


}
