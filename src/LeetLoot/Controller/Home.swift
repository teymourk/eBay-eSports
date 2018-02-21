//
//  ViewController.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/10/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Home: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView?.backgroundColor = .customGray
        collectionView?.registerCell(Featured_Events_Cell.self)
        collectionView?.registerCell(Twitter_Cell.self)
        collectionView?.registerCell(Favorites_Cell.self)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func setupTwitter() {
        
    }
}

//Mark: FeaturedEventDelegate
extension Home: FeaturedEventDelegate {
    func onEventBanner(_ sender: UITapGestureRecognizer) {
        let layout = UICollectionViewFlowLayout()
        let browseEvent = Browse_Event(collectionViewLayout: layout)
        navigationController?.pushViewController(browseEvent, animated: true)
    }
}
