//
//  BrowseCell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/9/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class BrowseCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //view for image (browse, games)
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func setupViews(){
        backgroundColor = .clear
        
        //image (browse, games)
        addSubview(titleImageView)
        titleImageView.frame = CGRectMake(0, 0, 375, 107)
        
        addSubview(carouselCollectionView)
        
        //to generate multiple cells in nested collection view
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        //register item cell to the collection view
        carouselCollectionView.register(CarouselCollectionView.self, forCellWithReuseIdentifier: cellId)
        
        //expand from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": carouselCollectionView]))
        
        //expand from top to bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-107-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": carouselCollectionView]))
    }
    
    //number of cells return in section, this will change based on if it's events or games
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CarouselCollectionView
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 160)
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}

/*class BrowseCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "itemCellId"
    
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
    
    //view for image (browse, games)
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    //view for merchandise carousel
    let merchCarouselView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    func setupViews(){

        backgroundColor = .clear
        
        //image (browse, games)
        addSubview(titleImageView)
        titleImageView.frame = CGRectMake(0, 0, 375, 107)
        
        //background for carousel
        addSubview(merchCarouselView)
        merchCarouselView.frame = CGRectMake(0, 107, 375, 160)
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
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
        backgroundColor = .customGray
    }
    
}*/
