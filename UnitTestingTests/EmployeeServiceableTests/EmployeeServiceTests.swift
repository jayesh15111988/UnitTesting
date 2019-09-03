//
//  EmployeeServiceableTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/29/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import XCTest
@testable import UnitTesting

final class EmployeeListTests: XCTestCase {

    var employeeService: MockEmployeeServiceable!
    var employeeServiceConsumer: EmployeeServiceConsumer!

    override func setUp() {
        super.setUp()
    }

    func testThatEmployeeConsumerSuccessfullyCreatesViewModels() {

        let dataLoadExpectation = expectation(description: "Employees data loaded successfully expectation")

        employeeService = MockEmployeeServiceable()

        employeeServiceConsumer = EmployeeServiceConsumer(employeeService: employeeService, completionHandler: {
            dataLoadExpectation.fulfill()
        })
        employeeServiceConsumer.loadEmployees()

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertEqual(employeeServiceConsumer.employeesViewModels.count, 10)
    }

}

class MockEmployeeServiceable: EmployeeServiceable {
    func loadEmployees() -> Promise<[Employee]> {
        let employees: [Employee] = JSONLoader.load(fromFile: "Employees")
        return Promise(value: employees)
    }
}
