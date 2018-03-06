//
//  AdditionalImagesCell.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/4/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class AdditionalImagesCell: ParentCell {
    
    var image: thumbnailImages? {
        didSet {
            if let imageUrl = image?.imageUrl {
                merchImage.downloadImages(url: imageUrl)
            }
        }
    }
    
    let merchImage = { () -> customeImage in
        let image = customeImage(frame: .zero)
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func setupView() {
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.softGrey.cgColor
        addSubview(merchImage)
        
        NSLayoutConstraint.activate([
            merchImage.leftAnchor.constraint(equalTo: leftAnchor),
            merchImage.rightAnchor.constraint(equalTo: rightAnchor),
            merchImage.topAnchor.constraint(equalTo: topAnchor),
            merchImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
