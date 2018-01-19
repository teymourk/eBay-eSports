//
//  ViewController.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/10/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Home: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = UIColor(red: 238, green: 239, blue: 241)
        collectionView?.register(Featured_Events_Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.register(Favorites_Cell.self, forCellWithReuseIdentifier: "Cells")
        collectionView?.register(Home_Header_Cell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Cells")
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}

