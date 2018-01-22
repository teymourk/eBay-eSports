//
//  d.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Merch_Cell: UICollectionViewCell {
    
    let merchImage = { () -> UIImageView in
        let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.layer.borderWidth = 0.5
            image.layer.borderColor = UIColor.lightGray.cgColor
            image.clipsToBounds = true
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var merchTitle = { () -> UITextView in
        let textView = UITextView()
            textView.isEditable = false
            textView.isSelectable = false
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //Attributed string for the title, price and rating Icon
    private func attributedFor(_ title: String, price: String) {
        guard   let textFont = UIFont(name: "Helvetica", size: 15) else { return }
        let attributedFont: Dictionary<NSAttributedStringKey, UIFont> = [.font :   textFont]
        
        let attributedText = NSMutableAttributedString(string: "\(title)\n", //Initialize Merch Details
            attributes: attributedFont)
        let priceAttributedString =  NSMutableAttributedString(string: "$\(price)\n", //Price
            attributes: attributedFont)
        
        let ratingImage = NSTextAttachment()
            ratingImage.image = UIImage(named: "fiveStars") //Rating Icons
        let ratingAttributedString = NSAttributedString(attachment: ratingImage)
        let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
        
        //Appending the attributes
        attributedText.append(priceAttributedString)
        attributedText.append(ratingAttributedString)
        merchTitle.attributedText = attributedText
    }
    
    private func setupLayoutContraints() {
        addSubview(merchImage)
        addSubview(merchTitle)
        
        NSLayoutConstraint.activate([
            merchImage.topAnchor.constraint(equalTo: topAnchor),
            merchImage.heightAnchor.constraint(equalToConstant: frame.width),
            merchImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            merchImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            merchTitle.topAnchor.constraint(equalTo: merchImage.bottomAnchor),
            merchTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            merchTitle.leadingAnchor.constraint(equalTo: merchImage.leadingAnchor, constant: -5),
            merchTitle.trailingAnchor.constraint(equalTo: merchImage.trailingAnchor)
        ])
    }
    
    private func setupView() {
        //Set title and price of merch from data object
        attributedFor("Poker Fanart", price: "14.99")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayoutContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
