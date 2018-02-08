//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load custom view
        setupCollectionView()
        
    }

    //Sets up the custom collection view for browse
    private func setupCollectionView(){
        collectionView?.backgroundColor = .customGray
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        
        
        
    }
    
    //how many cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    //cell itself
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 265)
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
}
