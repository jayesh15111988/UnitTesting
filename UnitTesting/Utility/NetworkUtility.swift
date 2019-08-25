//
//  NetworkUtility.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

enum ExternalRequestError: Error {
    case invalidURL
    case emptyData
    case invalidJSON
}

struct NetworkRequest {
    static func sendRequest(with urlString: String, completionBlock: @escaping ([Employee]) -> Void,  errorBlock: @escaping (ExternalRequestError) -> Void) {
        guard let url = URL(string: urlString) else {
            errorBlock(.invalidURL)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                errorBlock(.emptyData)
                return
            }

            do {
                let employees = try JSONDecoder().decode([Employee].self, from: data)
                completionBlock(employees)
            } catch {
                errorBlock(.invalidJSON)
            }
        }
        task.resume()
    }
}

