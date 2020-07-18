//
//  DoubleExtension.swift
//  Calculator
//
//  Created by Quoc Huy on 7/18/20.
//  Copyright © 2020 Quoc Huy. All rights reserved.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

