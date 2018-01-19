//
//  h.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Merch_Header_Cell: UICollectionViewCell {
    
    let colors: [UIColor] = [.red, .blue, .yellow]
    
    lazy var gameCarousel = { () -> ScrollView in
        let scrollView = ScrollView()
            scrollView.createScrollable(colors.count, view: self)
            scrollView.contentSize.width = bounds.size.width * CGFloat(colors.count)
            scrollView.delegate = self
        return scrollView
    }()
    
    lazy var pageControl = { () -> UIPageControl in
        let pageControl = UIPageControl()
            pageControl.numberOfPages = colors.count
            pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    private func handleScrollableImages() {
        colors.count.doTask {
            let image = UIImageView()
                image.backgroundColor = colors[$0]
                image.frame.size = bounds.size
                image.frame.origin.x = CGFloat($0) * bounds.size.width
            gameCarousel.addSubview(image)
        }
    }

    private func setupLayoutContraints() {
        addSubview(gameCarousel)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            
            gameCarousel.topAnchor.constraint(equalTo: topAnchor),
            gameCarousel.bottomAnchor.constraint(equalTo: bottomAnchor),
            gameCarousel.leadingAnchor.constraint(equalTo: leadingAnchor),
            gameCarousel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: gameCarousel.bottomAnchor, constant: -5),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
        ])
    }
    
    private func setupView() {
        setupLayoutContraints()
        handleScrollableImages()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Mark: - ScrollViewDelegate
extension Merch_Header_Cell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / Constants.kWidth
        pageControl.currentPage = Int(pageNumber)
    }
}
