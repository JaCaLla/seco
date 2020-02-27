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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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

        APIManager().getAllRoutes(onSucceed: { routesAPI in
            XCTAssertEqual(routesAPI.count, 7)

            asyncExpectation.fulfill()
        }, onFailed: { responseCode in
            XCTAssertEqual(responseCode, ResponseCodeAPI.responseValidationFailed)
            asyncExpectation.fulfill()
        })
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

    func test_getAllRoutes2() {
        let asyncExpectation = expectation(description: "\(#function)")

        
        APIManager().getAllRoutes2 { (result) in
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
}
