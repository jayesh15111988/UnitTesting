//
//  NumberScalerTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import UnitTesting

class MockScreenSizeable: ScreenSizeable {
    var size: CGSize {
        return CGSize(width: 375.0, height: 667.0)
    }
}

final class NumberScalerTests: XCTestCase {

    let numberScaler = NumberScaler(screenRect: MockScreenSizeable())

    // Tests the `NumberScaler` utility to check if the function scales the input number by the size of current device
    func testThatNumberScalesForTheGivenSize() {
        XCTAssertEqual(numberScaler.scale(with: 2), 2084)
    }
}
