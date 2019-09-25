//
//  ViewController.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/9/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet private weak var setTimeButton: UIButton!
    @IBOutlet private weak var setTimeLabel: UILabel!
    @IBOutlet private weak var timeTextField: UITextField!
    
    private var timePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlarmNotification.shared.getAuthorization { (granted) in
            print(granted)
        }
        
        setupDatePicker()
    }
    private func setupDatePicker() {
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .time
        timePicker?.addTarget(self, action: #selector(timeChange), for: .valueChanged)
        timeTextField.inputView = timePicker
    }
    
    @objc private func timeChange() {
        guard let date = timePicker?.date else {
            return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        timeTextField.text = dateFormatter.string(from: date)
    }
    
    @IBAction private func setButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let date = timePicker?.date else {
            return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        setTimeLabel.text = "Alarm set for \(dateFormatter.string(from: date))"
        setup(date: date)
    }
    
    private func setup(date: Date) {
        let triggerCalendar = Calendar.current.dateComponents([.hour, .minute], from: date)
        print(triggerCalendar)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerCalendar, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Wake up"
        content.sound = UNNotificationSound.defaultCritical
        
        let request = setupRequest(date: date)
        
        AlarmNotification.shared.center.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }

    }
    
    private func setupRequest(date: Date) -> UNNotificationRequest{
        let trigger = AlarmNotification.shared.createTrigger(date: date)
        let content = AlarmNotification.shared.createContent(title: "Wake up")
        let identifier = "AlarmId"
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
}


//
//    private func registerNotification() {
//        let options: UNAuthorizationOptions = [.alert, .sound]
//        center.requestAuthorization(options: options) { (granted, error) in
//            if !granted {
//                print("Something is wrong")
//            }
//        }
//    }
//
//    private func setupDatePicker() {
//        timePicker = UIDatePicker()
//        timePicker?.datePickerMode = .time
//        timePicker?.addTarget(self, action: #selector(timeChange), for: .valueChanged)
//        timeTextField.inputView = timePicker
//    }
//

//

//}
//
//extension ViewController: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("Notification did sent")
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("Notification did sent")
//    }
//}
