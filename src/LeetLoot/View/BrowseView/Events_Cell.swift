//
//  Events_Cell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/12/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

protocol EventCategoryDelegate: class {
    func onEvent(name: String)
}

class Events_Cell: ParentCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var categories: [Categories]?
    
    weak var delegate: EventCategoryDelegate?
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let browse = BrowseCategory.sampleBrowseCategories()
        categories = browse[0].categories
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let event = categories?[indexPath.item].id?.appending(" Expo") else { return }
        delegate?.onEvent(name: event)
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
