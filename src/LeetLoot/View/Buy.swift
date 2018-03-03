//
//  Buy.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/27/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Buy: Merch_Cell {
    
    var itemSummaries: items? {
        didSet {
            if let item = itemSummaries {
                merchTitle.attributedFor("League", price: "US $14.99", details: item.shortDescription)
                merchImage.downloadImages(url: "http://i.ebayimg.com/00/s/NjgyWDU4NQ==/z/ir8AAOSwzqFY~GMn/$_57.JPG?set_id=8800005007")
            }
        }
    }
    
    override func setupLayoutAttributes() {
        merchImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 2.5/3).isActive = true
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)

    }
}

//2.5/3 for x
//2/3 for 8+ / 8 

