//
//  BrowseCarousel.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/23/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class BrowseCarousel: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BrowseDelegate{
    
    func refreshItems() {
        itemsCollectionView.reloadData()
        itemsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    private let cellId = "cellId"
    
    var categories: [Categories]?
    
    var itemCategory: BrowseCategory? {
        didSet{
            let browseCategories = itemCategory?.categories
                categories = browseCategories
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let user = Auth.auth().currentUser?.uid
        if user != nil
        {Database.database().reference().child("users").child(user!).child("favorites").observe(.childChanged, with: { (snapshot) in
            print ("Changes: ", snapshot)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)
            self.refreshItems()
            //self.count = 1
            //self.grabFavInfo()
            //self.collectionView?.reloadData()
            //self.collectionView?.collectionViewLayout.invalidateLayout()
            //Determine if coordinate has changed
        })}
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func setupViews(){
        backgroundColor = .white
        
        addSubview(itemsCollectionView)
        
        //to generate multiple cells in nested collection view
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        
        //register item cell to the collection view
        itemsCollectionView.register(browseItemCell.self, forCellWithReuseIdentifier: cellId)

        NSLayoutConstraint.activate([
            itemsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            itemsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            itemsCollectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            itemsCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            
            ])
        
        
    }
    
    //number of cells return in section, this will change based on if it's events or games
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        if let count = categories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! browseItemCell
        cell.category = categories?[indexPath.item]
        cell.curGame = categories?[indexPath.item].id
        cell.delegate = self
        return cell
    }
    

    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
}
