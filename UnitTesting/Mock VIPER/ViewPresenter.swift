//
//  ViewPresenter.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

protocol ViewOutput: AnyObject {
    func getEmployees(with urlString: String)
    func refreshList()
}

final class ViewPresenter: ViewOutput {

    let viewInput: ViewInput
    let trackingManager: TrackingProtocol
    var repositoryInput: RepositoryInput?

    init(viewInput: ViewInput, trackingManager: TrackingProtocol) {
        self.viewInput = viewInput
        self.trackingManager = trackingManager
    }

    func getEmployees(with urlString: String) {
        repositoryInput?.loadEmployees(with: urlString, completion: { employees in
            self.dataReceived(employees: employees)
        }, errorHandler: { error in
            self.errorReceived(error: error)
        })
    }

    func refreshList() {
        trackingManager.trackClick(event: "refreshList")
        repositoryInput?.loadEmployees(with: baseURL, completion: { employees in
            self.dataReceived(employees: employees)
        }, errorHandler: { error in
            self.errorReceived(error: error)
        })
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
        switch error {
        case ExternalRequestError.emptyData:
            viewInput.showError(with: "Empty content. No network data received")
        case ExternalRequestError.invalidURL:
            viewInput.showError(with: "Invalid URL passed")
        default:
            viewInput.showError(with: "Unknown error occurred")
        }
    }
}
