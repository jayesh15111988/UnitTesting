//
//  MockViewRepository.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
@testable import UnitTesting

class MockViewRepository: RepositoryInput {

    let errorToPass: Error?

    init(errorToPass: Error?) {
        self.errorToPass = errorToPass
    }

    func loadEmployees(with urlString: String, completion: @escaping ([Employee]) -> Void, errorHandler: @escaping (Error) -> Void) {
        if let errorToPass = errorToPass {
            errorHandler(errorToPass)
        } else {
            let employees: [Employee] = JSONLoader.load(fromFile: urlString)
            completion(employees)
        }
    }

    func loadEmployees(with urlString: String) -> Promise<[Employee]> {
        if let errorToPass = errorToPass {
            return Promise(error: errorToPass)
        } else {
            let employees: [Employee] = JSONLoader.load(fromFile: urlString)
            return Promise(value: employees)
        }
    }
}
