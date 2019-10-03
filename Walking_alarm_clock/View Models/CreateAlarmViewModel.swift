//
//  CreateAlarmViewModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import UserNotifications

class CreateAlarmViewModel {
    
    private var alarm: AlarmModel?
    
    private let center = AlarmNotification.shared.center
    let alarmBuilder = AlarmBuilder()
    private let notificationBuilder = NotificationBuilder()
    
    func completeAlarm() {
        alarm = alarmBuilder.getAlarm()
    }
    
    func completeNotification() {
        guard let time = alarm?.time, let message = alarm?.message, let id = alarm?.alarmIdentifier else {
            return
        }
        notificationBuilder.reset()
        notificationBuilder.setContent(message)
        notificationBuilder.setTrigger(time)
        
        if let notification = notificationBuilder.getNotification(), let content = notification.content {
            let request = UNNotificationRequest(identifier: id,
                                                content: content,
                                                trigger: notification.trigger)
            
            center.add(request) { (error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
        }
    }
}
