//
//  RoutesPresenterUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class RoutesPresenterUT: XCTestCase {

    var sut: RoutesPresenter!
    var view: RoutesVCMock!//RoutesVCProtocol!
    var interactor: RoutesInteractorMock!//RoutesInteractorProtocol!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createSut()
    }

    func createSut() {

        interactor = RoutesInteractorMock()
        sut = RoutesPresenter(interactor: interactor)

        view = RoutesVCMock()

        sut.set(routesVC: view)
    }
   
    func test_fetchWhenExistsRoutes() {
           // Given
        interactor.routes = [ Route(driverName: "Alberto Morales",
                                        originAddress: "Barcelona",
                                        destinationAddress: "Martorell",
                                        startTime: "2018-12-18T08:00:00.000Z",
                                        endTime: "2018-12-18T09:00:00.000Z",
                                        points: [])]
            
           // When
           sut.fetchRoutes()
           let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
               guard let weakSelf = self else {
                   XCTFail()
                   alertExpectation.fulfill()
                   return
               }
               XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
               XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, true)
               XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
               XCTAssertEqual(weakSelf.view.presentCalled, false)
               XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, true)
               alertExpectation.fulfill()
           })

           wait(for: [alertExpectation], timeout: 1)
       }
    
    func test_fetchWhenError() {

        // When
        sut.fetchRoutes()
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentCalled, true)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, true)
            alertExpectation.fulfill()
        })

        wait(for: [alertExpectation], timeout: 1)
    }

}
