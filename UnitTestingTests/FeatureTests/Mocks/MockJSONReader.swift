//
//  File.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

class MockJSONReader {
    static func readJSONFromFile<T: Codable>(fileName: String) -> [T] {
        var objects: [T] = []

        if let path = Bundle(for: self).path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                objects = try JSONDecoder().decode([T].self, from: data)
            } catch {
                objects = []
            }
        }
        return objects
    }
}
