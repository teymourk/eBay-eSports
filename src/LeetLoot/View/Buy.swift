//
//  Buy.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/27/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Buy: Merch_Cell {
    
    private lazy var moreDetails: UIButton = {
        let button = UIButton()
            button.setTitle("See More Product Details >", for: .normal)
            button.contentHorizontalAlignment = .left
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buyNow: UIButton = {
        let button = UIButton()
            button.setImage(UIImage(named: "BuyNow"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupLayoutAttributes() {
        addSubview(buyNow)
        addSubview(moreDetails)
        
        NSLayoutConstraint.activate([
            merchImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 3.7/5),
            
            moreDetails.bottomAnchor.constraint(equalTo: buyNow.topAnchor, constant: -15),
            moreDetails.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            moreDetails.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            buyNow.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            buyNow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            buyNow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)
    
        merchTitle.attributedFor("League Of Legends Kindred New T-Shirt 3D Gaming ", price: "US $14.99", details: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis")
    }
}
