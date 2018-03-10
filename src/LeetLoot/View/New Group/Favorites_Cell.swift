//
//  Favorites_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Favorites_Cell: ParentCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    private lazy var merchButton: UIButton = {
        let button = UIButton(title: "See more", imageName: #imageLiteral(resourceName: "Arrow"))
        
        //button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0)
        
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 65).isActive = true
        button.imageView?.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
        
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

    
    //game logo image top left corner
    let gameImage: customeImage = {
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.downloadImages(url: "https://static-cdn.jtvnw.net/ttv-boxart/Overwatch-285x380.jpg")
        return iv
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Overwatch"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Regular", size:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartView: customeImage = {
        let hv = customeImage(frame: .zero)
        hv.contentMode = .scaleAspectFit
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.tintColor = UIColor.lightBlue
        hv.image = #imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate)
        hv.isUserInteractionEnabled = true
        return hv
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
       
        addSubview(gameImage)
        addSubview(textLabel)
        addSubview(heartView)
        addSubview(carouselCollectionView)
        addSubview(merchButton)
        
        //to generate multiple cells in nested collection view
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        //register item cell to the collection view
        carouselCollectionView.register(CarouselCollectionView.self, forCellWithReuseIdentifier: cellId)
        
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            gameImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            gameImage.heightAnchor.constraint(equalToConstant: 40),
            gameImage.widthAnchor.constraint(equalToConstant: 30),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -197),
            textLabel.leftAnchor.constraint(equalTo: gameImage.rightAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            
            heartView.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            heartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            heartView.heightAnchor.constraint(equalToConstant: 24),
            heartView.widthAnchor.constraint(equalToConstant: 22.2),
            
            carouselCollectionView.topAnchor.constraint(equalTo: gameImage.bottomAnchor, constant: 12),
            carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            merchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            merchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            ])
        backgroundColor = .white
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}


