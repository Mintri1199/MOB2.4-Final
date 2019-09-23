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
    
    private var alarmTime: Date? {
        didSet {
            setupTrigger()
        }
    }
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        setupDatePicker()
        registerNotification()
    }
    
    private func setupTrigger() {
        guard let alarmTime = alarmTime else {
            return
        }
        let triggerCalendar = Calendar.current.dateComponents([.hour, .minute], from: alarmTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerCalendar, repeats: false)
     
        let content = UNMutableNotificationContent()
        content.title = "Wake up"
        content.sound = UNNotificationSound.defaultCritical
        let identifier = "AlarmId"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if error != nil {
                print("Uh oh")
            }
        }
    }
    
    private func registerNotification() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something is wrong")
            }
        }
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
        alarmTime = date
    }
}
