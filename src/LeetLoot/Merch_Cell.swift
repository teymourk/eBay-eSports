//
//  d.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Merch_Cell: UICollectionViewCell {
    
    private func attributedFor(_ title: String) {
        let attributedText = NSMutableAttributedString(string: "\(title)\n\n",
            attributes: [.font :   UIFont.boldSystemFont(ofSize: 14)])
        
        let ratingImage = NSTextAttachment()
            ratingImage.image = UIImage(named: "fiveStars")
        let ratingAttributedString = NSAttributedString(attachment: ratingImage)
        let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .left
        
        attributedText.append(ratingAttributedString)
        merchTitle.attributedText = attributedText
    }
    
    let merchImage = { () -> UIImageView in
        let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.layer.borderWidth = 1
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
    
    private func setupLayoutContraints() {
        addSubview(merchImage)
        addSubview(merchTitle)
        
        let height = frame.width + 20
        
        NSLayoutConstraint.activate([
            merchImage.topAnchor.constraint(equalTo: topAnchor),
            merchImage.heightAnchor.constraint(equalToConstant: height),
            merchImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            merchImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            merchTitle.topAnchor.constraint(equalTo: merchImage.bottomAnchor),
            merchTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            merchTitle.leadingAnchor.constraint(equalTo: merchImage.leadingAnchor),
            merchTitle.trailingAnchor.constraint(equalTo: merchImage.trailingAnchor)
            
        ])
    }
    
    private func setupView() {
        attributedFor("item Title")
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
