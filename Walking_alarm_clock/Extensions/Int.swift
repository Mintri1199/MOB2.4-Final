//
//  File.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

extension Int {
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
}
