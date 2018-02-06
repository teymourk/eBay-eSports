//
//  Home+Extension.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation

import UIKit

//Mark: - CollectionViewDelegate + DataSource + DelegateFlowLayout
extension Home: UICollectionViewDelegateFlowLayout {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let featuredEventsCell: Featured_Events_Cell = collectionView.reusableCell(indexPath: indexPath)
        let twitterCell: Twitter_Cell = collectionView.reusableCell(indexPath: indexPath)
        let favoritesCell: Favorites_Cell = collectionView.reusableCell(indexPath: indexPath)
        
        if indexPath.section == 0 {
            return indexPath.row == 0 ? featuredEventsCell : twitterCell
        }
        return favoritesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let eventRow = CGSize(width: view.frame.width, height: 200)
        let twitterRow = CGSize(width: view.frame.width, height: 348)
        
        if indexPath.section == 0 {
            return indexPath.row == 0 ? eventRow : twitterRow
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
}

//Mark: - CollectionHeader
extension Home {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: Header_Cell = collectionView.reusableCell(indexPath: indexPath, kind: kind)
            header.title = indexPath.section == 0 ? "Featured Events" : "Favorites"

        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 40)
    }
}
