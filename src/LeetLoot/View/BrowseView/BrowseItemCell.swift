//
//  BrowseItemCell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/8/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class browseItemCell: UICollectionViewCell{
    
    var category: Categories? {
        didSet{
            if let imageName = category?.imageName {
                imageView.downloadImages(url: imageName)
                
                if category?.type == "game"{
                    heartView.isHidden = false}
                else {heartView.isHidden = true}
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let imageView: customeImage = {
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let heartView: customeImage = {
        let hv = customeImage(frame: .zero)
        hv.contentMode = .scaleAspectFit
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.tintColor = UIColor.softGrey
        hv.image = #imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate)
        hv.isUserInteractionEnabled = true
        return hv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("Add this game to favorites")
    }
    
    func setupViews(){
        
        addSubview(imageView)
        
        addSubview(heartView)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(browseItemCell.checkAction))
        gesture.cancelsTouchesInView = false
        heartView.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            heartView.topAnchor.constraint(equalTo: imageView.topAnchor),
            heartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -103),
            heartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 101),
            heartView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            ])
        
        
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.softGrey.cgColor
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}
