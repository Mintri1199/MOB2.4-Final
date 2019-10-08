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
    let collectionView: UICollectionView = {
        var view = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.updateDelegate = self
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        viewModel.populateArray {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped() {
        if let createVC: CreateAlarmViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateVC") as? CreateAlarmViewController {
            createVC.delegate = self
            navigationController?.pushViewController( createVC, animated: true)
        }
    }
}

extension HomeScreenViewController: ShouldDeleteRow, ShouldUpdateRow, ReloadData {
    func reloadModel() {
        viewModel.populateArray {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func deleteRow(_ index: Int) {
         collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func updateRow(_ index: Int) {
        collectionView.performBatchUpdates({
            self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }, completion: nil)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        let model = viewModel.alarmArray[indexPath.row]
        //cell.switch.isOn = model.enable
        //cell.backgroundColor = model.enable ? UIColor.white : UIColor.darkGray
        //cell.timeLabel.text = String.formatTime(date: model.time!)
        cell.backgroundColor = .black
        return cell
    }
}
