//
//  GeoConfigManager.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import Foundation

enum Country {
    case us
    case germany
    case uk
}

final class GeoConfigManager {

    static let shared = GeoConfigManager(country: .us)

    var country: Country

    private init(country: Country) {
        self.country = country
    }

    func getCurrencySymbol() -> String {
        switch country {
        case .us:
            return "$"
        case .germany:
            return "€"
        case .uk:
            return "£"
        }
    }
}

//func myDecentFunction() -> String {
//    var outputMessage = ""
//
//    if logic1() {
//        outputMessage += "1"
//    }
//
//    if logic2() {
//        outputMessage += "2"
//    }
//
//    if logic3() {
//        outputMessage += "3"
//    }
//
//    if logic4() {
//        outputMessage += "4"
//    }
//
//    return outputMessage
//}
//
//func logic1() -> Bool { return false }
//
//func logic2() -> Bool { return true }
//
//func logic3() -> Bool { return false }
//
//func logic4() -> Bool { return true }
//}
