//
//  Persistent.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

class Persistent {
    
    // MARK: - CONSTANT KEYS
    private let asked: String = "notificationAsked"
    private let alarmArrayKey: String = "alarmArray"
        
    let center = AlarmNotification.shared
    static let shared = Persistent()
    
    func checkPermission(completion: @escaping () -> Void) {
        let persmissionAsked = UserDefaults.standard.bool(forKey: asked)
        
        if !persmissionAsked {
                UserDefaults.standard.set(!persmissionAsked, forKey: self.asked)
                completion()
        }
    }
    
    func fetchAlarmIds() -> [String]? {
        if let nsData = UserDefaults.standard.object(forKey: alarmArrayKey) as? NSData {
            let data = Data(referencing: nsData)
            do {
                let idArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String]
                return idArray
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func fetchOneAlarm(_ id: String) -> AlarmModel? {
        if let data = UserDefaults.standard.object(forKey: id) as? Data {
            do {
                if let alarm = try  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? AlarmModel {
                    return alarm
                } else {
                    return nil
                }
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    func updateOneAlarm(from id: String, to new: AlarmModel) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: new, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addAlarm(_ alarm: AlarmModel) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: alarm, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: alarm.alarmIdentifier)
            
            if var array = self.fetchAlarmIds() {
                array.append(alarm.alarmIdentifier)
                updateArray(array)
            } else {
                createAlarmArray(alarm.alarmIdentifier)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createAlarmArray(_ id: String) {
        let initialArray: [String] = [id]
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: initialArray, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: alarmArrayKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func updateArray(_ newArray: [String]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: newArray, requiringSecureCoding: true)
            UserDefaults.standard.set(data, forKey: alarmArrayKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteOneAlarm(_ id: String) {
        UserDefaults.standard.removeObject(forKey: id)
        if let oldArray = fetchAlarmIds() {
            let newArray = oldArray.filter { $0 != id }
            updateArray(newArray)
        } else {
            print("There is no array to remove from")
        }
    }
}
