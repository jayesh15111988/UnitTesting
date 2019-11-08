//
//  ViewPresenter.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

protocol ViewOutput: AnyObject {
    func getEmployeesWithClosure(with urlString: String)
    func getEmployeesWithPromise(with urlString: String)
    func refreshListTapped()
    func trackDisplayInfo()
    func trackRefreshTap()
}

final class ViewPresenter: ViewOutput {

    let viewInput: ViewInput
    let trackingManager: TrackingProtocol
    var repositoryInput: RepositoryInput?

    init(viewInput: ViewInput, trackingManager: TrackingProtocol) {
        self.viewInput = viewInput
        self.trackingManager = trackingManager
    }

    func getEmployeesWithClosure(with urlString: String) {
        repositoryInput?.loadEmployees(with: urlString, completion: { employees in
            self.dataReceived(employees: employees)
        }, errorHandler: { error in
            self.errorReceived(error: error)
        })
    }

    func getEmployeesWithPromise(with urlString: String) {
        repositoryInput?.loadEmployees(with: urlString).then({ employees in
            self.dataReceived(employees: employees)
        }).catch  ({ error in
            self.errorReceived(error: error)
        })
    }

    func refreshListTapped() {
        trackRefreshTap()
        getEmployeesWithPromise(with: baseURL)
    }

    func trackRefreshTap() {
        trackingManager.trackTap(event: "refreshList")
    }

    func trackDisplayInfo() {
        trackingManager.trackTap(event: "info")
    }

    func formattedAddress(from address: Address) -> String {
        return "\(address.street)\n\(address.suite)\n\(address.city)\n\(address.zipcode)\n"
    }
}

extension ViewPresenter {
    func dataReceived(employees: [Employee]) {

        guard !employees.isEmpty else {
            viewInput.showError(with: "No employees found at given destination")
            return
        }

        var viewModels: [ViewModel] = []

        employees.forEach { employee in
            let standardAddress = formattedAddress(from: employee.address)
            viewModels.append(ViewModel(id: String(employee.id), username: employee.username, address: standardAddress))
        }

        viewInput.set(with: viewModels)
    }

    func errorReceived(error: Error) {
        if let error = error as? ExternalRequestError {
            switch error {
            case .emptyData:
                self.viewInput.showError(with: "Empty content. No network data received")
            case .invalidURL:
                self.viewInput.showError(with: "Invalid URL passed")
            case .invalidJSON:
                self.viewInput.showError(with: "Error occurred while decoding JSON data into Codable object")
            }
        } else {
            self.viewInput.showError(with: "Unknown Error occurred")
        }
    }
}
