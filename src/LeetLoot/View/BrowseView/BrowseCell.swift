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
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.translatesAutoresizingMaskIntoConstraints = false

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
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
 
        addSubview(blurEffectView)

        addSubview(textLabel)
        
        addSubview(browseCarousel)
        
        //to generate multiple cells in nested collection view
        browseCarousel.dataSource = self
        browseCarousel.delegate = self
        
        //register item cell to the collection view
        browseCarousel.register(BrowseCarousel.self, forCellWithReuseIdentifier: cellId)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -160),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            
            blurEffectView.topAnchor.constraint(equalTo: imageView.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            blurEffectView.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            blurEffectView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            textLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            textLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            browseCarousel.topAnchor.constraint(equalTo: topAnchor, constant: 107),
            browseCarousel.bottomAnchor.constraint(equalTo: bottomAnchor),
            browseCarousel.leftAnchor.constraint(equalTo: leftAnchor),
            browseCarousel.rightAnchor.constraint(equalTo: rightAnchor),
            
            ])

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
