//
//  IssuePresenterMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class IssuePresenterMock: IssuePresenterProtocol {
    
    var setIssueCalled: Bool = false
    var saveIssueCalled: Bool = false
    
    func set(issueVC: IssueVCProtocol) {
        setIssueCalled = true
    }
    
    func save(issue: Issue) {
        saveIssueCalled = true
    }
}
