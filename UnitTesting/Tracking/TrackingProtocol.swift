//
//  TrackingProtocol.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

protocol TrackingProtocol {
    func trackTap(event: String)
    func trackClick(xLocation: CGFloat, yLocation: CGFloat)
}

class TrackingManager: TrackingProtocol {
    func trackTap(event: String) {
        UserDefaults.standard.set(event, forKey: "Click")
    }

    func trackClick(xLocation: CGFloat, yLocation: CGFloat) {
        UserDefaults.standard.set(xLocation, forKey: "xLocation")
        UserDefaults.standard.set(yLocation, forKey: "yLocation")
    }
}
