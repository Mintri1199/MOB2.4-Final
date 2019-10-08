//
//  PedometerVC.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/22/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import UserNotifications



class PedometerVC: UIViewController {
    
    private let statusLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private let stepsCount: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private var currentStep: Int = 0 {
        didSet {
            if let requireSteps = self.viewModel?.alarmModel!.requiredSteps {
                if self.currentStep <= requireSteps {
                    stepsCount.text = "\(self.currentStep) / \(requireSteps)"
                } else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    var viewModel: StepVCViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.addSubview(stepsCount)
        setupLabel()
    }
    
    private func setupLabel() {
        NSLayoutConstraint.activate([
            stepsCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stepsCount.heightAnchor.constraint(equalToConstant: 100),
            stepsCount.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            stepsCount.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        stepsCount.text = "0 / \(viewModel?.alarmModel?.requiredSteps!)"
    }
}
