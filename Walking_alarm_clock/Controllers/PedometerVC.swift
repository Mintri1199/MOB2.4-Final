//
//  PedometerVC.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import CoreMotion

class PedometerVC: UIViewController {
    
    private let statusLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 100),
            statusLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        startTrackingActivityType()
    }
    
    
    
    
//    private func startTrackingActivityType() {
//      activityManager.startActivityUpdates(to: OperationQueue.main) {
//          [weak self] (activity: CMMotionActivity?) in
//
//          guard let activity = activity else { return }
//          DispatchQueue.main.async {
//              if activity.walking {
//                  self?.activityTypeLabel.text = "Walking"
//              } else if activity.stationary {
//                  self?.activityTypeLabel.text = "Stationary"
//              } else if activity.running {
//                  self?.activityTypeLabel.text = "Running"
//              } else if activity.automotive {
//                  self?.activityTypeLabel.text = "Automotive"
//              }
//          }
//      }
//    }
    
    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) { [weak self] (activity: CMMotionActivity?) in
            
            guard let activity = activity else {
                return }
            
            if activity.walking {
                self?.statusLabel.text = "Walking"
            } else if activity.stationary {
                self?.statusLabel.text = "Standing"
            } else if activity.running {
                self?.statusLabel.text = "Running"
            } else if activity.automotive {
                self?.statusLabel.text = "Automotive"
            }
        }
    }
}
