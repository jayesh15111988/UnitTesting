//
//  MockTrackingManager.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit
@testable import UnitTesting

class MockTrackingManager: TrackingProtocol {
    var didCallTrackClick = false
    var savedXLocation: CGFloat?
    var savedYLocation: CGFloat?
    func trackClick(xLocation: CGFloat, yLocation: CGFloat) {
        didCallTrackClick = true
        savedXLocation = xLocation
        savedYLocation = yLocation
    }

    var didCallTrackTap = false
    var lastTappedEvent: String?

    func trackTap(event: String) {
        didCallTrackTap = true
        lastTappedEvent = event
    }
}
