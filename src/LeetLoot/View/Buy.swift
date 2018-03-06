//
//  Buy.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/27/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Buy: Merch_Cell {
    
    override func configureCellFor(_ item: itemSummaries, itemHref: ItemHerf? = nil) {
        if let itemHref = itemHref {
            merchTitle.attributedFor("\(item.itemTitle)\n",
                                    price: item.fullPrice,
                                    IncludesShipping: item.shipping,
                                    details: itemHref.description)
            additionalImages.imagesCollection = itemHref.groupAadditionalImages
        }
    }

    override func setupLayoutAttributes() {
        var imageHeight: CGFloat = CGFloat()
        switch Constants.isDevice {
        case .X: imageHeight = (2.5/3)
        case .plus: imageHeight = (2/3)
        case .regular: imageHeight = (1.5/3)
        case .five: imageHeight = (1.3/3)
        case .None: return }

        additionalImages.heightAnchor.constraint(equalTo: widthAnchor, multiplier: imageHeight).isActive = true
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0)

    }
}
