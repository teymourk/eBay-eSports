//
//  d.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Merch_Cell: ParentCell {
    
    internal var items: (summary:itemSummaries?, href:ItemHerf?) {
        didSet {
            if let item = items.summary, let itemHref = items.href {
                configureCellFor(item, itemHref: itemHref)
            } else {
                if let item = items.summary {
                    configureCellFor(item)
                }
            }
        }
    }
    
    let additionalImages = { () -> AdditionalImagesCV in
        let view = AdditionalImagesCV()
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let merchImage = { () -> customeImage in
        let image = customeImage(frame: .zero)
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
    
    lazy private var stackView: UIStackView = {
        let subViews: [UIView] = self.isKind(of: Buy.self) ? [additionalImages, merchTitle] : [merchImage, merchTitle]
        let stack = UIStackView(arrangedSubviews: subViews)
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    func configureCellFor(_ item: itemSummaries, itemHref: ItemHerf? = nil) {
        //let detailsSize = item.itemTitle.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14.0)])
    
        let p =  80 / frame.width
        //print(item.itemTitle.count, p)
        
        let reducedText = item.itemTitle.reduceTextWith(53)
        
        merchTitle.attributedFor(reducedText, price: item.fullPrice)
        merchImage.downloadImages(url: item.imgURL)
    }

    private func setupStackView() {
        addSubview(stackView)
        
        if self.isKind(of: Buy.self) {
            additionalImages.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        } else {
            merchImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    internal func setupLayoutAttributes() {
        merchImage.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        merchTitle.textContainerInset = UIEdgeInsets(top: 5, left: -5, bottom: 0, right: 0)
    }
    
    override func setupView() {
        setupStackView()
        setupLayoutAttributes()
    }
}

extension UIView {
    
    func handleCellAnimation() { 
        UIView.animate(withDuration: 0.55) {
            self.alpha = 1
        }
    }
}
