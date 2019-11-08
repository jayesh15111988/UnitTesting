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

    override func tearDown() {
        trackingManager = nil
        viewInput = nil
        presenter = nil
        repository = nil
        super.tearDown()
    }

    func testTrackingForRefreshListTap() {
        presenter.trackRefreshTap()
        XCTAssertTrue(trackingManager.didCallTrackTap)
        XCTAssertEqual(trackingManager.lastTappedEvent, "refreshList")
    }

    func testTrackingForInfoTap() {
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        presenter.trackDisplayInfo()
        XCTAssertTrue(trackingManager.didCallTrackTap)
        XCTAssertEqual(trackingManager.lastTappedEvent, "info")
    }

    func testFormattedAddress() {
        let regularAddress = Address(street: "12 Kibana", suite: "101 Royal Suite", city: "Boston", zipcode: "02467")
        XCTAssertEqual(presenter.formattedAddress(from: regularAddress), "12 Kibana\n101 Royal Suite\nBoston\n02467\n")
    }
}

// MARK: Mocked closure based or synchronous response unit tests
extension FeatureTests {
    // Test run when `getEmployees` is called synchronously
    func testSyncGetEmployeesWithNonEmptyResponse() {
        presenter.getEmployeesWithClosure(with: "Employees")
        XCTAssertTrue(viewInput.didCallSetViewModels)
        XCTAssertEqual(viewInput.setViewModels?.count, 10)
    }

    func testSyncGetEmployeesWithEmptyResponse() {
        presenter.getEmployeesWithClosure(with: "EmptyEmployees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "No employees found at given destination")
    }

    func testSyncGetEmployeesWithEmptyDataError() {
        repository = MockViewRepository(errorToPass: ExternalRequestError.emptyData)
        presenter.repositoryInput = repository
        presenter.getEmployeesWithClosure(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Empty content. No network data received")
    }

    func testSyncGetEmployeesWithInvalidURLError() {
        repository = MockViewRepository(errorToPass: ExternalRequestError.invalidURL)
        presenter.repositoryInput = repository
        presenter.getEmployeesWithClosure(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Invalid URL passed")
    }

    func testSyncGetEmployeesWithDecodingError() {
        repository = MockViewRepository(errorToPass: ExternalRequestError.invalidJSON)
        presenter.repositoryInput = repository
        presenter.getEmployeesWithClosure(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Error occurred while decoding JSON data into Codable object")
    }

    func testSyncGetEmployeesWithDefaultError() {
        repository = MockViewRepository(errorToPass: NSError(domain: "UnitTests", code: 100, userInfo: nil))
        presenter.repositoryInput = repository
        presenter.getEmployeesWithClosure(with: "Employees")
        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Unknown Error occurred")
    }
}

//// MARK: Mocked promise based or asynchronous response unit tests
extension FeatureTests {
    func testGetEmployeesWithNonEmptyResponse() {
        let loadEmployeesRecordsExpectation = expectation(description: "Employees data loaded successfully expectation")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "Employees")

        waitForExpectations(timeout: 2.0, handler: nil)
        XCTAssertTrue(viewInput.didCallSetViewModels)
        XCTAssertEqual(viewInput.setViewModels?.count, 10)
    }

    func testAsyncGetEmployeesWithEmptyResponse() {

        let loadEmployeesRecordsExpectation = expectation(description: "Empty Employees data loaded")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "EmptyEmployees")

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "No employees found at given destination")
    }

    func testAsyncGetEmployeesWithEmptyDataError() {

        let loadEmployeesRecordsExpectation = expectation(description: "No Employees data received")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        repository = MockViewRepository(errorToPass: ExternalRequestError.emptyData)
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "Employees")

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Empty content. No network data received")
    }

    func testAsyncGetEmployeesWithInvalidURLError() {
        let loadEmployeesRecordsExpectation = expectation(description: "Invalid URL expectation")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        repository = MockViewRepository(errorToPass: ExternalRequestError.invalidURL)
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "Employees")

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Invalid URL passed")
    }

    func testAsyncGetEmployeesWithDecodingError() {
        let loadEmployeesRecordsExpectation = expectation(description: "Decoding error expectation")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        repository = MockViewRepository(errorToPass: ExternalRequestError.invalidJSON)
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "Employees")

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Error occurred while decoding JSON data into Codable object")
    }

    func testAsyncGetEmployeesWithDefaultError() {
        let loadEmployeesRecordsExpectation = expectation(description: "Unknown error expectation")
        viewInput = MockViewInput(completion: {
            loadEmployeesRecordsExpectation.fulfill()
        })
        presenter = ViewPresenter(viewInput: viewInput, trackingManager: trackingManager)
        repository = MockViewRepository(errorToPass: NSError(domain: "UnitTests", code: 100, userInfo: nil))
        presenter.repositoryInput = repository

        presenter.getEmployeesWithPromise(with: "Employees")

        waitForExpectations(timeout: 2.0, handler: nil)

        XCTAssertFalse(viewInput.didCallSetViewModels)
        XCTAssertTrue(viewInput.didCallShowErrorMessage)
        XCTAssertEqual(viewInput.shownErrorMessage, "Unknown Error occurred")
    }
}
