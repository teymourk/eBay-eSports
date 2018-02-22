//
//  CustomNavbar.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class CustomNavbar: ParentView {
    
    private let titleImage = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "EliteLootLogo"))
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func setupView() {
        addSubview(titleImage)
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalTo: heightAnchor),
            titleImage.topAnchor.constraint(equalTo: topAnchor, constant: -1),
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.trailingAnchor.constraintLessThanOrEqualToSystemSpacingAfter(trailingAnchor, multiplier: 1/2),
        ])
    }
}
