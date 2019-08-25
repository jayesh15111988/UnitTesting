//
//  TrackingProtocol.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

protocol TrackingProtocol {
    func trackClick(event: String)
}

class TrackingManager: TrackingProtocol {
    func trackClick(event: String) {
        UserDefaults.standard.set(event, forKey: "Click")
    }
}
