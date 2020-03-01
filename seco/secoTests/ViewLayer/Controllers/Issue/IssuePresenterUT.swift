//
//  IssuePresenterUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 29/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class IssuePresenterUT: XCTestCase {

    var sut: IssuePresenter!
      var view: IssueVCMock!//RoutesVCProtocol!
      var interactor: RoutesInteractorMock!//RoutesInteractorProtocol!

      override func setUp() {
          // Put setup code here. This method is called before the invocation of each test method in the class.
          createSut()
      }

      func createSut() {

          interactor = RoutesInteractorMock()
          sut = IssuePresenter(interactor: interactor)

          view = IssueVCMock()
          sut.set(issueVC: view)
      }
    
    func test_createIssue() {
        // Given
        let issue = Issue(route: "sdq{Fc}iLj@zR|W~TryCzvC??do@jkKeiDxjIccLhiFqiE`uJqe@rlCy~B`t@sK|i@",
                          name: "Sara",
                          surename: "Gutierrez",
                          email: "sagu@mailinator.com",
                          timestamp: 123,
                          report:"blah, blah", phone: "123456789")
        sut.save(issue: issue)
        
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            // Then
            XCTAssertEqual(weakSelf.interactor.createCalled, true)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, false)
            XCTAssertEqual(weakSelf.interactor.getStopCalled, false)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            
            alertExpectation.fulfill()
        })

        wait(for: [alertExpectation], timeout: 1)
        
    }

}
