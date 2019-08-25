//
//  ViewRepository.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

let baseURL = "https://jsonplaceholder.typicode.com/users"

protocol RepositoryInput: AnyObject {
    func loadEmployees(with urlString: String, completion: @escaping ([Employee]) -> Void, errorHandler: @escaping (Error) -> Void)
    func loadEmployees(with urlString: String) -> Promise<[Employee]>
}

class ViewRepository: RepositoryInput {

    func loadEmployees(with urlString: String, completion: @escaping ([Employee]) -> Void, errorHandler: @escaping (Error) -> Void) {
        NetworkRequest.sendRequest(with: baseURL, completionBlock: { employees in
            DispatchQueue.main.async {
                completion(employees)
            }
        }) { error in
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
    }

    func loadEmployees(with urlString: String) -> Promise<[Employee]> {
        let promise = Promise<[Employee]>(work: { fulfill, reject in
            NetworkRequest.sendRequest(with: urlString, completionBlock: { employees in
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
