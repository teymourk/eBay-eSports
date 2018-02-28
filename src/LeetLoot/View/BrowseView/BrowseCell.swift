//
//  BrowseCell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/9/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import Firebase

class BrowseCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    var browseCategory: BrowseCategory? {
        didSet{
            if let name = browseCategory?.name {
                textLabel.text = name
            }
            
            if let imageName = browseCategory?.imageName {
                imageView.downloadImages(url: imageName)

            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: customeImage = {
        let iv = customeImage()
        iv.image = UIImage(named: "")
        return iv
    }()

    //view for image (browse, games)
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Events"
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 60)
        return label
    }()
  
    let browseCarousel: UICollectionView = {
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
        addSubview(imageView)
        imageView.frame = CGRectMake(0, 0, 375, 107)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.frame = CGRectMake(0, 0, 375, 107)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
       
        addSubview(textLabel)
        textLabel.frame = CGRectMake(0, 0, 375, 107)
        
        
        addSubview(browseCarousel)
        
        //to generate multiple cells in nested collection view
        browseCarousel.dataSource = self
        browseCarousel.delegate = self
        
        //register item cell to the collection view
        browseCarousel.register(BrowseCarousel.self, forCellWithReuseIdentifier: cellId)
        
        //expand from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": browseCarousel]))
        
        //expand from top to bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-107-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": browseCarousel]))


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BrowseCarousel
        cell.itemCategory = browseCategory
        return cell
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
