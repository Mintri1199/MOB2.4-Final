//
//  StepsViewModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 10/2/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation
import CoreMotion

class StepVCViewModel {
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    var alarmModel: AlarmModel?
    
    let peristent = Persistent.shared
    
    func startCountingSteps(completion: @escaping (Int) -> Void) {
        pedometer.startUpdates(from: Date()) { pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else {
                return
            }
            completion(pedometerData.numberOfSteps.intValue)
        }
    }
    
    func startTracking(completion: @escaping () -> Void) {
        if CMPedometer.isStepCountingAvailable() {
            completion()
        }
    }
    
    func setAlarmModel(id: String) {
        guard let model = self.peristent.fetchOneAlarm(id) as? AlarmModel else {
            return
        }
        alarmModel = model
    }
}
