//
//  FibonacciUtilityTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import UnitTesting

class FibonacciUtilityTests: XCTestCase {

    var fibonacciUtility: FibonacciUtility!

    override func setUp() {
        super.setUp()
        fibonacciUtility = FibonacciUtility()
    }

    override func tearDown() {
        fibonacciUtility = nil
        super.tearDown()
    }

    func testFibonacciSequenceGenerationForValidinput() {
        XCTAssertEqual(try fibonacciUtility.generateFibonacciNumber(for: 1), 1)
        XCTAssertEqual(try fibonacciUtility.generateFibonacciNumber(for: 7), 13)
        XCTAssertEqual(try fibonacciUtility.generateFibonacciNumber(for: 12), 144)
    }

    func testFibonacciSequenceGenerationForInvalidinput() {
        XCTAssertThrowsError(try fibonacciUtility.generateFibonacciNumber(for: -1)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.invalidInput)
        }

        XCTAssertThrowsError(try fibonacciUtility.generateFibonacciNumber(for: -10)) { error in
            XCTAssertEqual(error as? FibonacciError, FibonacciError.invalidInput)
        }
    }
}
