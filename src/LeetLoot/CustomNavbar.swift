//
//  CustomNavbar.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class CustomNavbar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleImage = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "rupee"))
            image.clipsToBounds = true
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let title = { () -> UILabel in
        let label = UILabel()
            label.text = "Elite Loot"
            label.textColor = .lightBlue
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        addSubview(titleImage)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            titleImage.heightAnchor.constraint(equalTo: heightAnchor),
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.trailingAnchor.constraintLessThanOrEqualToSystemSpacingAfter(trailingAnchor, multiplier: 1/2),
            
            title.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: titleImage.trailingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
