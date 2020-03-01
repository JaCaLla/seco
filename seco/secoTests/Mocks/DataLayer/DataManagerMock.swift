//
//  DataManagerMock.swift
//  secoTests
//
//  Created by Javier Calatrava on 26/02/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
@testable import seco

class DataManagerMock: DataManagerProtocol {
    
    var issue = Issue(route: "asdf", name: "Pepito", surename: "Grillo", email: "pegri@mailinator.com", timestamp: 123, report:"blah, blah", phone: "123456789")
    
    func create(issue: Issue, onComplete: @escaping () -> Void) {
        self.issue = issue
        onComplete()
    }
    
    
    func getIssue(route: String, onComplete: @escaping (Issue?) -> Void) {
        onComplete(issue)
    }

    func getStop(stopId: Int, onComplete: @escaping (Result<StopPoint, Error>) -> Void) {
        let stopPoint = StopPoint(stopTime: "2018-12-18T09:00:00.000Z",
                                  paid: false,
                                  userName: "Manuel Gomez")
        onComplete(.success(stopPoint))
    }


    func getAllRoutes(onComplete: @escaping (Result<([Route]), Error>) -> Void) {
        let routes:[Route] = [Route(route: "1",
                                    driverName: "Alberto Morales",
                            originAddress: "Barcelona",
                            destinationAddress: "Martorell",
                            startTime: "2018-12-18T08:00:00.000Z",
                            endTime: "2018-12-18T09:00:00.000Z",
                            points: [],
                            hasIssue: false),
                      Route(route: "2",
                            driverName: "Julian Valdivia",
                            originAddress: "La Junquera",
                            destinationAddress: "Lleida",
                            startTime: "2018-12-18T18:00:00.000Z",
                            endTime: "2018-12-18T19:00:00.000Z",
                            points: [],
                            hasIssue: true),
        ]



        onComplete(.success(routes))
    }
    
    func getIssuesCount() -> Int {
        1
    }
}
