//
//  FeatureTests.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
import XCTest
@testable import UnitTesting

class FeatureTests: XCTestCase {

    var viewInput: MockViewInput!
    var presenter: ViewPresenter!
    var repository: MockViewRepository!
    var trackingManager: MockTrackingManager!

    override func setUp() {
        super.setUp()

        trackingManager = MockTrackingManager()
        viewInput = MockViewInput()
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        repository = MockViewRepository(errorToPass: nil)
        presenter.repositoryInput = repository
    }

    func testTrackingForRefreshList() {
        presenter.refreshList()
        XCTAssertTrue(trackingManager.didCallTrackingClick)
        XCTAssertEqual(trackingManager.lastClickedEvent, "refreshList")
    }

    func testFormattedAddress() {
        let regularAddress = Address(street: "12 Kibana", suite: "101 Royal Suite", city: "Boston", zipcode: "02467")
        XCTAssertEqual(presenter.formattedAddress(from: regularAddress), "12 Kibana\n101 Royal Suite\nBoston\n02467\n")
    }

    func testGetEmployeesWithNonEmptyResponse() {
        presenter.getEmployees(with: "Employees")
        XCTAssertTrue(viewInput.didCallSetViewModels)
        XCTAssertEqual(viewInput.setViewModels?.count, 10)
    }

    func testGetEmployeesWithEmptyResponse() {
        presenter.getEmployees(with: "EmptyEmployees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "No employees found at given destination")
    }

    func testGetEmployeesWithEmptyDataError() {
        repository = MockViewRepository(errorToPass: ExternalRequestError.emptyData)
        presenter.repositoryInput = repository
        presenter.getEmployees(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Empty content. No network data received")
    }

    func testGetEmployeesWithInvalidURLError() {
        repository = MockViewRepository(errorToPass: ExternalRequestError.invalidURL)
        presenter.repositoryInput = repository
        presenter.getEmployees(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Invalid URL passed")
    }

    func testGetEmployeesWithDefaultError() {
        repository = MockViewRepository(errorToPass: NSError(domain: "Unknown", code: 100, userInfo: nil))
        presenter.repositoryInput = repository
        presenter.getEmployees(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Unknown error occurred")
    }

    override func tearDown() {
        viewInput = nil
        presenter = nil
        repository = nil
        trackingManager = nil
        super.tearDown()
    }
}
