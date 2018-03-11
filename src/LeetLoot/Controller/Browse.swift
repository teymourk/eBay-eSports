//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout, AlertDelegate {
    
    func sendAlert() {
        let alert = UIAlertController(title: "Not Signed In", message: "Sign in to start favoriting games.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private let cellId = "cellId"
   var browseCategories: [BrowseCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sendAlert()
        browseCategories = BrowseCategory.sampleBrowseCategories()
        
        //collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.backgroundColor = .customGray
        collectionView?.register(BrowseCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BrowseCell
        
        cell.browseCategory = browseCategories?[indexPath.item]

        return cell
    }
    
    
    
    //num cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = browseCategories?.count {
            return count
        }
        return 0
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 265)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }

}
