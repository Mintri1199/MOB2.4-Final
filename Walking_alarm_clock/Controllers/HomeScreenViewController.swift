//
//  HomeScreenViewController.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 10/2/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    let viewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.updateDelegate = self
        // Do any additional setup after loading the view.
    }
}

extension HomeScreenViewController: ShouldDeleteRow, ShouldUpdateRow {
    
    func deleteRow(_ index: Int) {
        // collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func updateRow(_ index: Int) {
//        collectionView.performBatchUpdates({
//            self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
//        }, completion: nil)
    }
}

extension HomeScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.alarmArray.isEmpty {
            // Setup empty view
            return 0
        } else {
            // remove empty view
            return viewModel.alarmArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "alarmCell", for: indexPath) // as Custom Cell Class (guard this as well)
        let model = viewModel.alarmArray[indexPath.row]
        //cell.switch.isOn = model.enable
        //cell.backgroundColor = model.enable ? UIColor.white : UIColor.darkGray
        //cell.timeLabel.text = String.formatTime(date: model.time!)
        
        return cell
    }
}
