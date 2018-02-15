//
//  Featured_Events_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Featured_Events_Cell: ParentCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    private lazy var merchButton: UIButton = {
        let button = UIButton()
        button.setTitle("See more", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button;
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CarouselCollectionView
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 130)
    }
    
    override func setupView() {
        addSubview(carouselCollectionView)
        addSubview(merchButton)
        
        //to generate multiple cells in nested collection view
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        //register item cell to the collection view
        carouselCollectionView.register(CarouselCollectionView.self, forCellWithReuseIdentifier: cellId)
        
        //expand from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": carouselCollectionView]))
        
        //expand from top to bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-85-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": carouselCollectionView]))
        
        NSLayoutConstraint.activate([
            merchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            merchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            ])
        
        backgroundColor = .white
    }
    
}
