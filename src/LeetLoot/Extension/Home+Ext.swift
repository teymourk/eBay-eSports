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
        guard
            let featuredEventsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Featured_Events_Cell,
            let favoritesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cells", for: indexPath) as? Favorites_Cell  else { return UICollectionViewCell() }
        
        return indexPath.section == 0 ? featuredEventsCell : favoritesCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionOne = CGSize(width: view.frame.width, height: 200)
        let sectionTwo = CGSize(width: view.frame.width, height: view.frame.height)
        
        return indexPath.section == 0 ? sectionOne : sectionTwo
    }
}

//Mark: - CollectionHeader
extension Home {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Cells", for: indexPath) as? Home_Header_Cell
        
        header?.title.text = indexPath.section == 0 ? "Featured Events" : "Favorites"
        
        return header ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 40)
    }
}
