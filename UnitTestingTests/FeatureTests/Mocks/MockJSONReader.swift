//
//  File.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
import XCTest

class JSONLoader {
    static func load<T: Codable>(fromFile name: String) -> [T] {
        var objects: [T] = []

        if let path = Bundle(for: self).path(forResource: name, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                objects = try JSONDecoder().decode([T].self, from: data)
            } catch {
                XCTFail("Something went wrong while reading data from file \(name)")
            }
        } else {
            XCTFail("Could not find the file \(name) in test bundle")
        }
        return objects
    }
}
