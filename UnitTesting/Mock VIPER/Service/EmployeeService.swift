//
//  EmployeeService.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/29/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

protocol EmployeeServiceable {
    func loadEmployees() -> Promise<[Employee]>
}

final class EmployeeService: EmployeeServiceable {
    func loadEmployees() -> Promise<[Employee]> {
        let promise = Promise<[Employee]>(work: { fulfill, reject in
            NetworkRequest.sendRequest(with: baseURL, completionBlock: { employees in
                DispatchQueue.main.async {
                    fulfill(employees)
                }
            }) { error in
                DispatchQueue.main.async {
                    reject(error)
                }
            }
        })
        return promise
    }
}
