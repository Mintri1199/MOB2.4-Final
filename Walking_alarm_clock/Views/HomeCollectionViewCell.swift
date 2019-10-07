//
//  HomeCollectionViewCell.swift
//  Walking_alarm_clock
//
//  Created by Ruhsane Sawut on 10/7/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    let containerView = UIView()
    let cornerRadius: CGFloat = 15.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutView() {
        // set the shadow of the view's layer
//        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.borderWidth = 0.2
        layer.shadowOpacity = 0.6
//        layer.shadowRadius = 4.0
        layer.cornerRadius = cornerRadius

        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true

        addSubview(containerView)

        //
        // add additional views to the containerView here
        //

        // add constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // pin the containerView to the edges to the view
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
