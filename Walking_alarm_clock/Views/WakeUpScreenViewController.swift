//
//  WakeUpScreenViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class WakeUpScreenViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startWalkingButton: UIButton!
    
    let date = Date()
    let format = "MMM dd, yyy EEEE"
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // date label
        dateFormatter.dateFormat = format
        dateLabel.text = dateFormatter.string(from: date)
                
        // current time label
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector:#selector(self.tick) , userInfo: nil, repeats: true)
        
        startWalkingButton.titleLabel?.text = "Start Walking"
        
    }
    
    
    @objc func tick() {
        dateFormatter.dateFormat = format
        dateLabel.text = dateFormatter.string(from: date)
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
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
