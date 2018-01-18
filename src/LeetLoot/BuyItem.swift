//
//  BuyItem.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class BuyItem: NSObject {
    lazy var view = { () -> UIView in
        let view = UIView(frame: CGRect(x: 0, y: height, width: width, height: height/2))
            view.backgroundColor = .white
        return view
    }()
    
    lazy var fadeBackgroud = { ()-> UIView in
        let view = UIView(frame: Constants.kWindow.frame)
            view.backgroundColor = .black
            view.alpha = 0
        return view
    }()
    
    let width = Constants.kWidth
    let height = Constants.kHeight
    let window = Constants.kWindow
    
    func openPage() {
        window.addSubview(fadeBackgroud)
        window.addSubview(view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y = (self.height) - (self.height / 2)
            self.view.frame = CGRect(x: 0, y: y, width: Constants.kWidth, height: self.height/2)
            self.fadeBackgroud.alpha = 0.5
            
        })
    }
}
