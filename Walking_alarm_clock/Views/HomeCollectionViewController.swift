//
//  HomeCollectionViewController.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/2/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let viewModel = HomeScreenViewModel()
    var tempModel = ["alarm1", "alarm2", "alarm3"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor.white
        print(Persistent.shared.fetchAlarmIds())
        
        setupBarView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.populateArray()
        collectionView.reloadData()
    }
    
    private func setupBarView() {
        navigationItem.title = "Alarms"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        collectionView.collectionViewLayout = layout
    }
    
    @objc private func addTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "EditAlarmViewController") as? EditAlarmViewController {
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @objc private func testingAddTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "CreateVC") as? CreateAlarmViewController {
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Setup empty view or remove it if the array is empty
        return viewModel.alarmArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        // Configure the cell
        let selectedModel = viewModel.alarmArray[indexPath.row]
        cell.timeLabel.text = String.formatTime(date: selectedModel.time)
        cell.enableSwitch.isOn = selectedModel.enable
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 50, height: view.frame.height/5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this alarm?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { action in
            switch action.style{
            case .default:
        //        remove from datasource array
        //        viewModel.alarmArray.remove(at: indexPath.row)
                self.tempModel.remove(at: indexPath.row)
                
                // get the alarm id
                
                //remove from persistent
        //        Persistent.shared.deleteOneAlarm(<#T##id: String##String#>)
                
                // reload collection view
                collectionView.deleteItems(at: [indexPath])

            case .cancel:
                self.dismiss(animated: true, completion: nil)

            case .destructive:
                print("destructive")
                
            @unknown default:
                print("unknown")
            }}))
        self.present(alert, animated: true, completion: nil)
        
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }
}

extension HomeCollectionViewController: NewlyAddedTime {
    func reloadData() {
        viewModel.populateArray()
        collectionView.reloadData()
    }
}
