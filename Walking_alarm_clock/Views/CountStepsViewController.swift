//
//  CountStepsViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/8/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import CoreMotion

class CountStepsViewController: UIViewController {
    
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var stepsNum: UILabel!
    @IBOutlet weak private var dismissView: UIView!
    @IBOutlet weak private var dismissButton: UIButton!
    private let date = Date()
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    
    var requiredSteps: Int? = 20
    var currentSteps: Int = 0 {
        didSet {
            if let steps = self.requiredSteps {
    
                DispatchQueue.main.async {
                    self.stepsNum.text = "\(self.currentSteps)/ \(self.requiredSteps ?? 20)"
                }
                
                if currentSteps == steps {
                    pedometer.stopUpdates()
                    DispatchQueue.main.async {
                        self.dismissView.isHidden = false
                        self.dismissButton.isHidden = false
                    }
                }
            }
        }
    }
    
    @IBAction private func dismissTapped(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = date.toString()
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        stepsNum.text = "0/ \(requiredSteps ?? 20)"
        startTracking()
    }
    
    private func startTracking() {
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        }
    }
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) { [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else {
                return
            }
            self?.currentSteps = pedometerData.numberOfSteps.intValue
        }
    }
}
