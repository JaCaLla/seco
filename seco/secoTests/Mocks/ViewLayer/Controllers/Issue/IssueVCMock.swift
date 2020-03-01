//
//  IssueVCMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco
class IssueVCMock: IssueVCProtocol {

    var presentActivityIndicatorCalled: Bool = false
    var removeActivityIndicatorCalled: Bool = false
    var onDismissedCalled: Bool = false

    func presentActivityIndicator() {
        presentActivityIndicatorCalled = true
    }

    func removeActivityIndicator() {
        removeActivityIndicatorCalled = true
    }

    func dismiss() {
        onDismissedCalled = true
    }

}
