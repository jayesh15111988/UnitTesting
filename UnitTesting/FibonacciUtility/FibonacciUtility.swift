//
//  FibonacciUtility.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

enum FibonacciError: Error {
    case invalidInput
}

final class FibonacciUtility {

func generateFibonacciNumber(for sequence: Int) throws -> Int {

    guard sequence >= 0 else { throw FibonacciError.invalidInput }

    var num1 = 0
    var num2 = 1

    for _ in 0..<sequence {
        let num = num1 + num2
        num1 = num2
        num2 = num
    }
    return num1
}
}
