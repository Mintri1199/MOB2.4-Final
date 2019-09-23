//
//  AlarmModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

struct AlarmModel {
    var setTime: Date
    var repeated: Bool
    var alarmIdentifier: String // Must be unique 
    var coreDataId: String
    
}
