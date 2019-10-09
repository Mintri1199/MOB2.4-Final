//
//  EditAlarmViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class EditAlarmViewController: UIViewController {

    // time picker
    @IBOutlet weak var timePicker: UIDatePicker!
    
    // keyboard only shows number pad for steps input field
    @IBOutlet weak var stepsNumberInputField: UITextField!
    
    // back button
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // done button
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        // number of steps the user has to walk
        // if the text field is empty or invalid, automatically set to 20 steps
        // getNumSteps() returns: Int
        let numSteps = getNumSteps()
        print(numSteps)
        
        let alarmTime = timePicker.date
        print(alarmTime)
        
        // TODO: save this new alarm
        
    }
    
    func getNumSteps() -> Int
    {
        
        // parse only int from input using extension
        // if no valid integer is found from input,
        // number of steps default is set to 20
        let number = Int.parse(from: stepsNumberInputField.text ?? "20")
        if number == nil {
            return 20
        } else {
            return number!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
