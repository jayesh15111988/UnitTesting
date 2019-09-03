//
//  EmployeeServiceConsumer.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/29/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

final class EmployeeServiceConsumer {

    struct EmployeeViewModel {
        let id: Int
        let name: String
    }

    let employeeService: EmployeeServiceable
    var employeesViewModels: [EmployeeViewModel]
    let completionHandler: (() -> Void)?

    init(employeeService: EmployeeServiceable, completionHandler: (() -> Void)? = nil) {
        self.employeeService = employeeService
        self.employeesViewModels = []
        self.completionHandler = completionHandler
    }

func loadEmployees() {
    self.employeeService.loadEmployees().then({ [weak self] employees in
        self?.employeesViewModels = employees.map { EmployeeViewModel(id: $0.id, name: $0.username) }
        self?.completionHandler?()
    })
}
}
