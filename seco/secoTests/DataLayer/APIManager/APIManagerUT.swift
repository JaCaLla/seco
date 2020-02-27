//
//  APIManagerUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 24/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class APIManagerUT: XCTestCase {


    // MARK: - Router
    func test_RouterAttributes() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(APIManager.APIRouter.host, "europe-west1-metropolis-fe-test.cloudfunctions.net")
        XCTAssertEqual(APIManager.APIRouter.scheme, "https")
        XCTAssertEqual(APIManager.APIRouter.baseURLString, "https://europe-west1-metropolis-fe-test.cloudfunctions.net")
    }

    func test_routesUrl() {

        let createSession = APIManager.APIRouter.routes
        XCTAssertEqual(createSession.method, .get)
        XCTAssertEqual(createSession.path, "api/trips")
        XCTAssertEqual(createSession.resolveURLRequest().httpMethod ?? "", "GET")

        XCTAssertEqual(createSession.resolveURLRequest().url?.absoluteString,
                       "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/trips")
    }


    func test_stopUrl() {

        let createSession = APIManager.APIRouter.stop(2)
        XCTAssertEqual(createSession.method, .get)
        XCTAssertEqual(createSession.path, "api/stops/2")
        XCTAssertEqual(createSession.resolveURLRequest().httpMethod ?? "", "GET")

        XCTAssertEqual(createSession.resolveURLRequest().url?.absoluteString,
                       "https://europe-west1-metropolis-fe-test.cloudfunctions.net/api/stops/2")
    }

    func test_getAllRoutes() {
        let asyncExpectation = expectation(description: "\(#function)")


        APIManager().getAllRoutes { (result) in
            switch result {
            case .success(let routesAPI):
                XCTAssertEqual(routesAPI.count, 7)
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_getStop() {
        let asyncExpectation = expectation(description: "\(#function)")

        APIManager().getStop(stopId: 1) { result in
            switch result {
            case .success(let stopPointAPI):
                XCTAssertEqual(stopPointAPI.price, 1.5)
                XCTAssertEqual(stopPointAPI.pointAPI, PointAPI(latitude: 41.37653, longitude: 2.17924))
                XCTAssertEqual(stopPointAPI.stopTime, "2018-12-18T08:10:00.000Z")
                XCTAssertEqual(stopPointAPI.paid, true)
                XCTAssertEqual(stopPointAPI.address, "Ramblas, Barcelona")
                XCTAssertEqual(stopPointAPI.tripID, 1)
                XCTAssertEqual(stopPointAPI.userName, "Manuel Gomez")
            case .failure:
                XCTFail()

            }
            asyncExpectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
}
