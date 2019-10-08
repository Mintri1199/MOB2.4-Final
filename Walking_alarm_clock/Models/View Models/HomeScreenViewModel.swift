//
//  HomeScreenViewModel.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/30/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import Foundation

protocol ShouldDeleteRow: class {
    func deleteRow(_ index: Int)
}

protocol ShouldUpdateRow: class {
    func updateRow(_ index: Int)
}

class HomeScreenViewModel {
    
    var alarmArray: [AlarmModel] = []
    weak var delegate: ShouldDeleteRow?
    weak var updateDelegate: ShouldUpdateRow?
    
    private func populateArray() {
        if let idArray = Persistent.shared.fetchAlarmIds() {
            alarmArray = idArray.compactMap { id in Persistent.shared.fetchOneAlarm(id) }
        } else {
            alarmArray = []
        }
    }
    
    func updateOne(_ id: String) {
        if let updatedModel = Persistent.shared.fetchOneAlarm(id) {
            if let index = alarmArray.firstIndex(where: { $0.alarmIdentifier == id }) {
                alarmArray[index] = updatedModel
                updateDelegate?.updateRow(index)
            }
        }
    }
    
    func delete() {
        if let idArray = Persistent.shared.fetchAlarmIds() {
            var deleteItemIndex: Int?
            for (index, value) in alarmArray.enumerated() {
                if !idArray.contains(value.alarmIdentifier) {
                    deleteItemIndex = index
                    break
                }
            }
            if let deleteItemIndex = deleteItemIndex {
                alarmArray.remove(at: deleteItemIndex)
                delegate?.deleteRow(deleteItemIndex)
            }
        }
    }
}
