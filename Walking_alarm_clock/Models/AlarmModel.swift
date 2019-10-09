//
//  AlarmModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmModel: NSObject, NSCoding {
    
    var time: Date
    var enable: Bool = true
    var alarmIdentifier: String = String.random(length: 20)
    var requiredSteps: Int
    var message: String
    
    init(_ time: Date, _ enable: Bool = true, _ steps: Int, _ message: String) {
        self.time = time
        self.enable = true
        self.requiredSteps = steps
        self.message = message
    }
    
    required convenience init?(coder: NSCoder) {
        guard let time = coder.decodeObject(forKey: "time") as? Date,
            let message = coder.decodeObject(forKey: "message") as? String,
            let id = coder.decodeObject(forKey: "Id") as? String else {
                self.init(Date(), false, 0, "")
                return }
        let enable = coder.decodeBool(forKey: "enable")
        let steps = coder.decodeInteger(forKey: "steps")
        
        self.init(time, enable, steps, message)
        self.alarmIdentifier = id
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(time as NSDate, forKey: "time")
        coder.encode(enable, forKey: "enable")
        coder.encode(alarmIdentifier, forKey: "Id")
        coder.encode(requiredSteps, forKey: "steps")
        coder.encode(message, forKey: "message")
    }
}

class AlarmBuilder {
    private var alarm: AlarmModel?
    
    func reset() {
        alarm = AlarmModel(Date(), true, 0, "Wake Up")
    }
    
    func setTime(_ time: Date) {
        alarm?.time = time
    }
    
    func setSteps(_ num: Int) {
        alarm?.requiredSteps = num
    }
    
    func setMessage(_ message: String) {
        alarm?.message = message
    }
    
    func getAlarm() -> AlarmModel? {
        guard let alarm = alarm else {
            return nil
        }
        return alarm
    }
}
