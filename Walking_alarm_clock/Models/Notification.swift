//
//  Notification.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationModel {
    var trigger: UNCalendarNotificationTrigger?
    var content: UNNotificationContent?
}

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
    
    func getAuthorization(completion: @escaping (Bool) -> Void) {
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus != .authorized {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func removeNotification(_ id: String) {
    
    }
}

class NotificationBuilder {
    private var notification: NotificationModel?
    
    func reset() {
        notification = NotificationModel()
    }
    
    func setTrigger(_ date: Date) {
        let calendar = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: calendar, repeats: true)
        notification?.trigger = trigger
    }
    
    func setContent(_ message: String) {
        let content = UNMutableNotificationContent()
        content.title = message
        content.sound = .defaultCritical
        notification?.content = content
    }
    
    func getNotification() -> NotificationModel? {
        guard let notification = notification else {
            return nil
        }
        return notification
    }
}
