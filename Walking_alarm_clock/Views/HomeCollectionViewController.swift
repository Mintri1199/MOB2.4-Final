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
        
        return CGSize(width: view.frame.width - 50, height: view.frame.height / 5)
    }
}

extension HomeCollectionViewController: NewlyAddedTime {
    func reloadData() {
        viewModel.populateArray()
        collectionView.reloadData()
    }
}
