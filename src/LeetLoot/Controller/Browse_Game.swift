//
//  Browse_Game.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Game: UICollectionViewController {
    
    let buyItem = { () -> BuyItem in
        let view = BuyItem()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register HeaderCell + ColleCtionCell
        collectionView?.register(Merch_Header_Cell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CellH")
        collectionView?.register(Merch_Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
        title = "Game Title"
    }
}

