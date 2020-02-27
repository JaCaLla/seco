//
//  RoutesVCUT.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import XCTest
@testable import seco
class RoutesVCUT: XCTestCase {

    var sut: RoutesVC!
    let presenter = RoutesPresenterMock()
    
    override func setUp() {
        createSut()
    }
    
    func createSut() {
        
        sut = RoutesVC.instantiate(presenter: presenter)
        sut.loadViewIfNeeded()
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        //_ = sut.view
    }


    func test_instantiate() {
        XCTAssertNotNil(sut.presenter, "Presenter not initialized")
        XCTAssertEqual(presenter.setRoutesCalled, true)
        XCTAssertEqual(presenter.fetchRoutesCalled, true)
        
    }

}
