
//
//  Filter_Cell.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Filter_Cell: UITableViewCell {
    
    let checkImage = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "CheckMark"))
            image.contentMode = .scaleAspectFit
            image.isHidden = true
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func setupLayout() {
        addSubview(checkImage)
        NSLayoutConstraint.activate([
            checkImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.5),
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupLayout()
    }
}

