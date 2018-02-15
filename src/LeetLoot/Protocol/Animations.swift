//
//  Animations.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/14/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol fadeInAnimation {}

extension fadeInAnimation where Self: UIView {
    func handleCellAnimation() {
        transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alpha = 1
        })
    }
}

extension UICollectionViewCell: fadeInAnimation {}
