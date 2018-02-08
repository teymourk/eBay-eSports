//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load custom view
        setupCollectionView()
        
    }

    //Sets up the custom collection view for browse
    private func setupCollectionView(){
        collectionView?.backgroundColor = .customGray
        collectionView?.register(imageCell.self, forCellWithReuseIdentifier: "cellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    //how many cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    //cell itself
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        //cell.backgroundColor = .white
        
        return cell
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

/*Cell for image*/
class imageCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    //view for image (browse, games)
    let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    //view for merchandise caroseul
    let merchCarouselView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    func setUpViews(){
        addSubview(titleImageView)
        titleImageView.frame = CGRectMake(0, 0, 375, 107)
        
        addSubview(merchCarouselView)
        merchCarouselView.frame = CGRectMake(0, 107, 375, 158)
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
