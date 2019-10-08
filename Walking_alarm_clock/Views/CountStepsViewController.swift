//
//  CountStepsViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class CountStepsViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stepsNum: UILabel!
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissTapped(_ sender: Any) {
        // TODO: go back to home collection view, not wake up screen
        self.dismiss(animated: true, completion: nil)
    }
    
    let date = Date()
    let requiredSteps = 3
    var currentSteps: Int = 0 {
        didSet {
            // update steps label when steps increase
            self.stepsNum.text = String(currentSteps)
            
            // if met required steps, show dismiss view
            if currentSteps == requiredSteps {
                dismissView.isHidden = false
                dismissButton.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // date label
        dateLabel.text = date.toString()
                
        // current time label
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        
    }
    
    
    @objc func tick() {
        dateLabel.text = date.toString()
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        currentSteps += 1
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
