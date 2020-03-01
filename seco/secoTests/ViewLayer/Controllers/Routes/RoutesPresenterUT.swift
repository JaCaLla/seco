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
        interactor.routes = [Route(route: "1",
                                   driverName: "Alberto Morales",
                                   originAddress: "Barcelona",
                                   destinationAddress: "Martorell",
                                   startTime: "2018-12-18T08:00:00.000Z",
                                   endTime: "2018-12-18T09:00:00.000Z",
                                   points: [],
                                   hasIssue: false)]

        // When
        sut.fetchRoutes()
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            // Then
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, true)
            XCTAssertEqual(weakSelf.interactor.getStopCalled, false)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, true)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentCalled, false)
            XCTAssertEqual(weakSelf.view.presentPopUpCalled, false)
            XCTAssertEqual(weakSelf.view.onGetIssue, false)
            
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
            // Then
            XCTAssertEqual(weakSelf.view.presentCalled, true)
            XCTAssertEqual(weakSelf.view.presentPopUpCalled, false)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, true)
            XCTAssertEqual(weakSelf.interactor.getStopCalled, false)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.onGetIssue, false)
            
            alertExpectation.fulfill()
        })

        wait(for: [alertExpectation], timeout: 1)
    }

    func test_fetchExistingStopPoint() {
        // Given
        interactor.stopPoint = StopPoint(stopTime: "2018-12-18T09:00:00.000Z",
                                         paid: true,
                                         userName: "Manolo García")

        // When
        sut.fetchStopPoint(stopId: 3)
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            // Then
            XCTAssertEqual(weakSelf.interactor.getStopCalled, true)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentCalled, false)
            XCTAssertEqual(weakSelf.view.presentPopUpCalled, true)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.onGetIssue, false)
            alertExpectation.fulfill()
        })

        wait(for: [alertExpectation], timeout: 1)
    }
    
    func test_fetchNotExistingStopPoint() {
        // Given
        // When
        sut.fetchStopPoint(stopId: 3)
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            
            // Then
            XCTAssertEqual(weakSelf.view.presentCalled, true)
            XCTAssertEqual(weakSelf.view.presentPopUpCalled, false)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, false)
            XCTAssertEqual(weakSelf.interactor.getStopCalled, true)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.onGetIssue, false)
            
            alertExpectation.fulfill()
        })

        wait(for: [alertExpectation], timeout: 1)
    }
    
    func test_getIssue() {
        // Given
        // Then
        sut.fetchIssue(route: "asdf")
        let alertExpectation = XCTestExpectation(description: "testAlertShouldAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let weakSelf = self else {
                XCTFail()
                alertExpectation.fulfill()
                return
            }
            
            // Then
            XCTAssertEqual(weakSelf.interactor.getIssueCalled, true)
            XCTAssertEqual(weakSelf.view.onGetIssue, true)
            XCTAssertEqual(weakSelf.view.presentCalled, false)
            XCTAssertEqual(weakSelf.view.presentPopUpCalled, false)
            XCTAssertEqual(weakSelf.interactor.getAllRoutesCalled, false)
            XCTAssertEqual(weakSelf.interactor.getStopCalled, false)
            XCTAssertEqual(weakSelf.view.presentActivityIndicatorCalled, true)
            XCTAssertEqual(weakSelf.view.presentFetchedRoutesCalled, false)
            XCTAssertEqual(weakSelf.view.removeActivityIndicatorCalled, true)
            
            alertExpectation.fulfill()
        })
        wait(for: [alertExpectation], timeout: 1)
    }

}
