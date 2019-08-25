//
//  UnitTestingTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import UnitTesting

class PasswordCheckerTest: XCTestCase {

    // The unit tests below will verify the exception that will be thrown as a part of an invalid input password.

    // When password is too short, it will throw an error of type TooShort

    func testShortPasswordException() {
        let passwordChecker = PasswordChecker(password: "sample")

        XCTAssertThrowsError(try passwordChecker.checkPassword()) { error in
            XCTAssertEqual(error as? PasswordError, PasswordError.TooShort)
        }
    }

    // When password does not contain any numeric, it will throw an error of type NoNumber

    func testNoNumberPasswordException() {
        let passwordChecker = PasswordChecker(password: "samplepasswordforus")
        XCTAssertThrowsError(try passwordChecker.checkPassword()) { error in
            XCTAssertEqual(error as? PasswordError, PasswordError.NoNumber)
        }
    }

    // When password is a common word, it will throw an error of type CustomMessage(let message)

    func testCommonPasswordException() {
        let passwordChecker = PasswordChecker(password: "password")
        XCTAssertThrowsError(try passwordChecker.checkPassword()) { error in
            guard case PasswordError.CustomMessage(let message) = error else {
                return XCTFail("Failed to get expected kind of error from Password Checker utility")
            }
            XCTAssertEqual(message, "Common keyword used as a password")

            // Alternatively, this can also be checked with the following line of code
            XCTAssertEqual(error as? PasswordError, PasswordError.CustomMessage(message: "Common keyword used as a password"))
        }
    }

    // Following tests will verify the returned value by passwordChecker function. It involves valid input.

    func testValidPasswords() {
        let passwordChecker = PasswordChecker(password: "samplepasswordforus1234")
        XCTAssertNoThrow(try passwordChecker.checkPassword())
    }
}

// Make sure to implement PasswordError to conform to Equatable protocol. Without such conformance, XCTAssertEqual on ErrorType will throw a compiler error.

extension PasswordError: Equatable {
    public static func ==(lhs: PasswordError, rhs: PasswordError) -> Bool {
        switch (lhs, rhs) {
        case (.TooShort, .TooShort):
            return true
        case (.NoNumber, .NoNumber):
            return true
        case (let .CustomMessage(message1), let .CustomMessage(message2)):
            return message1 == message2
        default:
            return false
        }
    }
}
