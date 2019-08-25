//
//  PasswordChecker.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

// Enum to maintain error conditions in the app.
enum PasswordError: Error {
    case TooShort
    case NoNumber
    case CustomMessage(message: String)
}

class PasswordChecker {

    let password: String

    init(password: String) {
        self.password = password
    }

    func checkPassword() throws -> Bool {
        // Password should not be a common word.
        guard password.lowercased() != "password" else {
            throw PasswordError.CustomMessage(message: "Common keyword used as a password")
        }

        // Password should have at least specific length.
        guard self.password.count >= 8 else {
            throw PasswordError.TooShort
        }

        // Password should have at least one number in it
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard texttest1.evaluate(with: password) == true else {
            throw PasswordError.NoNumber
        }
        // If no error conditions are encountered, return true.
        return true
    }
}
