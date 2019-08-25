//
//  MockTrackingManager.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
@testable import UnitTesting

class MockTrackingManager: TrackingProtocol {
    var didCallTrackingClick = false
    var lastClickedEvent: String?

    func trackClick(event: String) {
        didCallTrackingClick = true
        lastClickedEvent = event
    }
}
