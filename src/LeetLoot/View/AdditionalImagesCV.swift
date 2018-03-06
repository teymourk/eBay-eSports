//
//  AdditionalImagesCV.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/4/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class AdditionalImagesCV: ParentView {
    
    var imagesCollection: [thumbnailImages]? {
        didSet {
            let indexPath = IndexPath(item: 0, section: 0)
            additionalImagesCV.selectItem(at: indexPath, animated: false, scrollPosition: .left)
            additionalImagesCV.reloadData()
            imageIndex = 1
        }
    }
    
    var imageIndex: Int = 0 {
        willSet {
            if let arrayCount = imagesCollection?.count {
                let counts = "\(newValue) / \(arrayCount)"
                imageCount.text = counts
            }
        }
    }
    
    private lazy var additionalImagesCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            cv.isPagingEnabled = true
            cv.showsHorizontalScrollIndicator = false
            cv.delegate = self
            cv.dataSource = self
            cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let imageCount = { () -> UILabel in
        let text = UILabel()
            text.font = UIFont.systemFont(ofSize: 13)
            text.textAlignment = .center
            text.textColor = .white
            text.backgroundColor = .darkGray
            text.layer.masksToBounds = true
            text.layer.cornerRadius = 5
            text.layer.borderWidth = 0.5
            text.layer.borderColor = UIColor.white.cgColor
            text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func setupView() {
        additionalImagesCV.registerCell(AdditionalImagesCell.self)
        addSubview(additionalImagesCV)
        addSubview(imageCount)
        
        NSLayoutConstraint.activate([
            additionalImagesCV.topAnchor.constraint(equalTo: topAnchor),
            additionalImagesCV.bottomAnchor.constraint(equalTo: bottomAnchor),
            additionalImagesCV.leadingAnchor.constraint(equalTo: leadingAnchor),
            additionalImagesCV.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageCount.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            imageCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            imageCount.widthAnchor.constraint(equalToConstant: 60),
            imageCount.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

extension AdditionalImagesCV: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCollection?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AdditionalImagesCell = collectionView.reusableCell(indexPath: indexPath),
            img = imagesCollection?[indexPath.item]
        cell.image = img
        
        return cell
    }
}

extension AdditionalImagesCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
}

extension AdditionalImagesCV {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let contentOffset = Int(targetContentOffset.pointee.x / frame.width) + 1
        imageIndex = contentOffset
    }
}
