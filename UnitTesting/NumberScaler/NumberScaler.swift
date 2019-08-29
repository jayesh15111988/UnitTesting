//
//  NumberScaler.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/25/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

protocol ScreenSizeable {
    var size: CGSize { get }
}

extension CGRect: ScreenSizeable { }

final class NumberScaler {

    let screenRect: ScreenSizeable

    init(screenRect: ScreenSizeable) {
        self.screenRect = screenRect
    }

    func scale(with number: Int) -> Int {
        return Int(screenRect.size.width + screenRect.size.height) * number
    }
}
