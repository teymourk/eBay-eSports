//
//  CarouselCollectionView.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/9/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


class CarouselCollectionView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        //expand from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemsCollectionView]))
        
        //expand from top to bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemsCollectionView]))
        
        
    }
    
   //number of cells return in section, this will change based on if it's events or games
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }


    
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }*/
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
}

//cell where the event, game, or merch is displayed in carasel
class ItemCell: UICollectionViewCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.softGrey.cgColor
    }
    
}
