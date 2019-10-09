//
//  EditAlarmViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

protocol NewlyAddedTime: class {
    func reloadData()
}

class EditAlarmViewController: UIViewController {

    @IBOutlet weak private var timePicker: UIDatePicker!
    @IBOutlet weak private var stepsNumberInputField: UITextField!
    @IBOutlet weak private var backButton: UIButton!
    @IBOutlet weak private var doneButton: UIButton!

    private let viewModel: CreateAlarmViewModel = CreateAlarmViewModel()
    weak var delegate: NewlyAddedTime?
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func doneButtonPressed(_ sender: Any) {
        viewModel.alarmBuilder.reset()
        viewModel.alarmBuilder.setMessage("Wake up")
        viewModel.alarmBuilder.setSteps(getNumSteps())
        viewModel.alarmBuilder.setTime(timePicker.date)
        viewModel.completeAlarm()
        viewModel.completeNotification()
        viewModel.setPersistent()
        delegate?.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func getNumSteps() -> Int {
        if let number = Int.parse(from: stepsNumberInputField.text ?? "20") {
            return number
        } else {
            return 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
