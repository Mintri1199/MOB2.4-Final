//
//  Date.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String = "MMM dd, yyy EEEE") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
