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
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if error != nil {
                completion(false)
            }
            completion(granted)
        }
    }
    
    func getAuthorization(completion: @escaping (Bool) -> ()) {
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus != .authorized {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func createTrigger(date: Date) -> UNCalendarNotificationTrigger {
        let calendar = Calendar.current.dateComponents([.hour, .minute], from: date)
        return UNCalendarNotificationTrigger(dateMatching: calendar, repeats: false)
    }
    
    func createContent(title: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .defaultCritical
        return content
    }
    
}
