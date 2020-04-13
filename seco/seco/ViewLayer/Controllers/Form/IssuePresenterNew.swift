//
//  File.swift
//  seco
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation

protocol IssueFormPresenterProtocol {
    func set(issueVC: IssueVProtocol)
    func save(issue: Issue)
}

class IssuePresenterNew {
    // MARK: - Private attributes
    private var interactor: RoutesInteractorProtocol = RoutesInteractor()
    private  var view: IssueVProtocol?

    // MARK: - Initializer/Constructor
    init(interactor: RoutesInteractorProtocol = RoutesInteractor()) {
        self.interactor = interactor
    }
}

// MARK:- IssuePresenterProtocol
extension IssuePresenterNew: IssueFormPresenterProtocol {
    func save(issue: Issue) {
        self.view?.presentActivityIndicator()
        self.interactor.create(issue: issue, onComplete: { [weak self] in
            DispatchQueue.main.async {
                self?.view?.removeActivityIndicator()
                self?.view?.dismiss()
            }
        })
    }


    func set(issueVC: IssueVProtocol) {
        self.view = issueVC
    }
}
