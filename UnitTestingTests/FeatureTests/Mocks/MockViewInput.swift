//
//  MockViewInput.swift
//  UnitTestingTests
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation
@testable import UnitTesting

class MockViewInput: ViewInput {
    var setViewModels: [ViewModel]?
    var didCallSetViewModels = false
    let completion: (() -> Void)?

    init(completion: (() -> Void)? = nil) {
        self.completion = completion
    }

    func set(with viewModels: [ViewModel]) {
        didCallSetViewModels = true
        setViewModels = viewModels
        completion?()
    }

    var shownErrorMessage: String?
    var didCallShowErrorMessage = false
    func showError(with message: String) {
        didCallShowErrorMessage = true
        shownErrorMessage = message
        completion?()
    }

    
}
