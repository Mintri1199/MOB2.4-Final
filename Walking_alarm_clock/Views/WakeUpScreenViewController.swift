//
//  WakeUpScreenViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class WakeUpScreenViewController: UIViewController {

    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var startWalkingButton: UIButton!
    
    let date = Date()
    var requireSteps: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = date.toString()
                
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
        // start walking button
        startWalkingButton.titleLabel?.text = "Start Walking"
    }
    
    @IBAction private func startWalkingTapped(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CountStepsViewController") as? CountStepsViewController,
        let steps = requireSteps else {
            return
        }
        vc.requiredSteps = steps
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func tick() {
        dateLabel.text = date.toString()
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }
}
