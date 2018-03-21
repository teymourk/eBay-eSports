//
//  ToastNotification.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/20/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


class Toast: NSObject {
    
    var text: String? {
        willSet {
            show(with: newValue!)
        }
    }
    
    private let message = { () -> UILabel in
        let label = UILabel()
            label.backgroundColor = .gray
            label.textAlignment = .center
            label.textColor = .white
            label.font = .systemFont(ofSize: 13)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 15
            label.alpha = 0
        return label
    }()
    
    private let window = Constants.kWindow
    
    private func show(with text: String) {
        let textSize = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 13.0)])
        let width = textSize.width * 1.5
        let height = textSize.height * 2
        let yOffset = Constants.isDevice == .X ? 60 : 30
        message.text = text
        message.frame.size = CGSize(width: width, height: height)
        message.center.x = window.center.x
        message.center.y = window.frame.height - CGFloat(yOffset)
        
        window.addSubview(message)
        
        UIView.animate(withDuration: 0.6, delay: 0.6, options: .curveEaseInOut, animations: {
            self.message.alpha = 1
        }) { (completed) in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: .curveEaseOut, animations: {
                self.message.alpha = 0
            }, completion: { (true) in
                self.message.removeFromSuperview()
            })
        }
    }
}
