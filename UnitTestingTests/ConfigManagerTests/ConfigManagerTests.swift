//
//  ConfigManagerTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
import XCTest
@testable import UnitTesting

class ConfigManagerTests: XCTestCase {
    let configManager = GeoConfigManager.shared

    func testUSCurrencySymbol() {
        configManager.country = .us
        XCTAssertEqual(configManager.getCurrencySymbol(), "$", "Failed to match currency symbol for given country. Expected $, got \(configManager.getCurrencySymbol())")
    }

    func testGermanCurrencySymbol() {
        configManager.country = .germany
        XCTAssertEqual(configManager.getCurrencySymbol(), "€", "Failed to match currency symbol for given country. Expected €, got \(configManager.getCurrencySymbol())")

    }

    func testUKCurrencySymbol() {
        configManager.country = .uk
        XCTAssertEqual(configManager.getCurrencySymbol(), "£", "Failed to match currency symbol for given country. Expected £, got \(configManager.getCurrencySymbol())")
    }
}
