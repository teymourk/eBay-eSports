//
//  Scroll.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/13/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class ScrollView: UIScrollView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        backgroundColor = .white
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//Mark- ScrollView Methods For creating different kinds of scrollViews
extension ScrollView {
    func createScrollableViews(forPages pages: [UIViewController], controller: UIViewController) {
        for (index, value) in pages.enumerated() {
            controller.addChildViewController(value)
            addSubview(value.view)
            value.didMove(toParentViewController: controller)
            
            var pageFrame = CGRect()

            pageFrame.origin.x = controller.view.frame.width * CGFloat(index)
            value.view.frame = pageFrame
        }
    }
    
    func createScrollable(_ number: Int, view: UICollectionViewCell) {
        let colors: [UIColor] = [.red, .blue, .yellow]
        number.doTask {
            let image = UIImageView()
                image.backgroundColor = colors[$0]
                image.frame.size = view.bounds.size
                image.frame.origin.x = CGFloat($0) * view.bounds.size.width
            addSubview(image)
        }
    }
}
