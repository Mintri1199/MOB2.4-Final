//
//  CreateAlarmViewController.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/9/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import UserNotifications

protocol ReloadData: class {
    func reloadModel()
}

class CreateAlarmViewController: UIViewController {
    
    @IBOutlet private weak var setTimeButton: UIButton!
    @IBOutlet private weak var setTimeLabel: UILabel!
    @IBOutlet private weak var timeTextField: UITextField!
    @IBOutlet private weak var stepsTextField: UITextField!
    
    private var timePicker: UIDatePicker?
    private let viewModel: CreateAlarmViewModel = CreateAlarmViewModel()
    
    weak var delegate: ReloadData?
    
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
            return
        }
        timeTextField.text = String.formatTime(date: date)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        guard let date = timePicker?.date else {
            return
        }
            
        let steps = stepsTextFieldValidation()
        viewModel.alarmBuilder.reset()
        viewModel.alarmBuilder.setMessage("Wake up")
        viewModel.alarmBuilder.setSteps(steps)
        viewModel.alarmBuilder.setTime(date)
        viewModel.completeNotification()
        Persistent.shared.addAlarm(viewModel.alarmBuilder.getAlarm()!)
        delegate?.reloadModel()
        navigationController?.popViewController(animated: true)
    }
    @objc private func doneTapped() {
        guard let date = timePicker?.date else {
            return
        }
            
        let steps = stepsTextFieldValidation()
        viewModel.alarmBuilder.reset()
        viewModel.alarmBuilder.setMessage("Wake up")
        viewModel.alarmBuilder.setSteps(steps)
        viewModel.alarmBuilder.setTime(date)
        viewModel.completeNotification()
        delegate?.reloadModel()
        navigationController?.popViewController(animated: true)
    }
    
    private func stepsTextFieldValidation() -> Int {
        guard let text = stepsTextField.text else {
            return 0
        }
        return Int(text) ?? 0
    }
}
