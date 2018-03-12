//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @objc func sendAlert() {
        let alert = UIAlertController(title: "Not Signed In", message: "Sign in to start favoriting games.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func refreshBrowse() {
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    
    private let cellId = "cellId"
   var browseCategories: [BrowseCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendAlert), name: NSNotification.Name(rawValue: "sendAlertBrowse"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBrowse), name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
        
        let user = Auth.auth().currentUser?.uid
         if user != nil
         {Database.database().reference().child("users").child(user!).child("favorites").observe(.childChanged, with: { (snapshot) in
         print ("Changes: ", snapshot)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)
        //self.collectionView?.reloadData()
        //self.collectionView?.collectionViewLayout.invalidateLayout()
         //Determine if coordinate has changed
         })}
        
        
       
        browseCategories = BrowseCategory.sampleBrowseCategories()
        
        //collectionView?.contentInsetAdjustmentBehavior = .never
        collectionView?.backgroundColor = .customGray
        collectionView?.register(BrowseCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
