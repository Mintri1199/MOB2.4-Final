//
//  Notification.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UserNotifications

// Using the singleton pattern since there should be only one user notification center
class AlarmNotification {
    
    let center = UNUserNotificationCenter.current()
    static let shared = AlarmNotification()
    
    // MARK: - notification configuring functions 
}
