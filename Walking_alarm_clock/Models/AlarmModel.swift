//
//  AlarmModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

enum Day {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

struct AlarmModel {
    var setTime: Date
    var enable: Bool
    var repeatable: Bool
    var alarmIdentifier: String
    var coreDataId: String
}
