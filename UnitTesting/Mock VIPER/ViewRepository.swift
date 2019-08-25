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
}
