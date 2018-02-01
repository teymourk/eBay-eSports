//
//  d.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Merch_Cell: ParentCell {
    
    let merchImage = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "testImg"))
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let merchTitle = { () -> UITextView in
        let textView = UITextView()
            textView.isEditable = false
            textView.isSelectable = false
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [merchImage, merchTitle])
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setupStackView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            merchImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    internal func setupLayoutAttributes() {
        merchImage.layer.borderWidth = 0.5
        merchImage.layer.borderColor = UIColor.lightGray.cgColor
        merchImage.clipsToBounds = true
        merchImage.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        merchTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -5).isActive = true
        merchTitle.attributedFor("League Of Legends", price: "$414.99")
    }
    
    override func setupView() {
        setupStackView()
        setupLayoutAttributes()
    }
}
