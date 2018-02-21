//
//  Featured_Events_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

protocol FeaturedEventDelegate {
    func onEventBanner(_ sender: UITapGestureRecognizer)
}

class Featured_Events_Cell: ParentCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    
    private lazy var eventBanner: UIImageView = {
        let banner = UIImageView()
        banner.image = UIImage(named: "E3Banner.png")
        banner.isUserInteractionEnabled = true
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()
    
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
    
    var delegate: FeaturedEventDelegate?

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
    
    @objc
    fileprivate func onEventBanner(_ sender: UITapGestureRecognizer) {
        guard   delegate != nil else { return }
                delegate?.onEventBanner(sender)
    }
    
    override func setupView() {
        addSubview(eventBanner)
        addSubview(carouselCollectionView)
        addSubview(merchButton)
        
        //to generate multiple cells in nested collection view
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        //register item cell to the collection view
        carouselCollectionView.register(CarouselCollectionView.self, forCellWithReuseIdentifier: cellId)
        
        NSLayoutConstraint.activate([
            eventBanner.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            eventBanner.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            eventBanner.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            eventBanner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -190.7),
            
            carouselCollectionView.topAnchor.constraint(equalTo: eventBanner.bottomAnchor, constant: 15),
            carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -47),

            merchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            merchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onEventBanner(_:)))
            tapGesture.numberOfTapsRequired = 1
        self.eventBanner.addGestureRecognizer(tapGesture)
        
        backgroundColor = .white
    }
    
}
