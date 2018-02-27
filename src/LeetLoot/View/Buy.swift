//
//  Buy.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/27/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Buy: Merch_Cell {
    
    override func setupLayoutAttributes() {
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)
    
        merchTitle.attributedFor("League Of Legends Kindred New T-Shirt 3D Gaming ", price: "US $14.99", details: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis")
    }
}
