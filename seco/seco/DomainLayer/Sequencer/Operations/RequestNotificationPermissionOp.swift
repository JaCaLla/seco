//
//  RequestNotificationPermissionOp.swift
//  seco
//
//  Created by Javier Calatrava on 01/03/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import Foundation
import UIKit

class RequestNotificationPermissionOp: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                if error != nil {
                    // success!
                }
                self.state = .finished
            }
        }
    }
}
