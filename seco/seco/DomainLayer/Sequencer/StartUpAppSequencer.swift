//
//  StartUpAppSequencer.swift
//  vlng
//
//  Created by Javier Calatrava Llaveria on 21/05/2019.
//  Copyright © 2019 Javier Calatrava Llaveria. All rights reserved.
//


import Foundation
import UIKit

class  StartUpAppSequencer {
    fileprivate let operationQueue = OperationQueue()

    func start() {

        let presentMainAppOperation = PresentMainAppOperation()

        let operations = [presentMainAppOperation]

        // Add operation dependencies
       
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
}
