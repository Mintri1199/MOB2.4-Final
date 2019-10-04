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
    private let viewModel: CreateAlarmViewModel = CreateAlarmViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        timeTextField.text = String.formatTime(date: date)
    }
    
    @objc private func doneTapped() {
        
//        Guard to get the number of step and date exist, setpsTextFieldValidation() else return
            
//        viewModel.alarmBuilder.reset()
//        viewModel.alarmBuilder.setMessage("Wake up")
//        viewModel.alarmBuilder.setSteps(<#T##num: Int##Int#>)
//        viewModel.alarmBuilder.setTime(<#T##time: Date##Date#>)
//        viewModel.completeNotification()
    }
    
    private func stepsTextFieldValidation() -> Bool {
        // Guard let text in textField else return false
        let string = ""
        return Int(string) != nil
    }
}
