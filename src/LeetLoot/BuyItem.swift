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
        let view = UIView(frame: CGRect(x: edgeOffset, y: height, width: width - 40, height: height/1))
            view.layer.cornerRadius = 5
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
    let edgeOffset: CGFloat = 10
    
    func openPage() {
        window.addSubview(fadeBackgroud)
        window.addSubview(view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let y = (self.height) - (self.height / 2) - 40 //Needs to be Safelayout constant
            self.view.frame = CGRect(x: self.edgeOffset, y: y, width: Constants.kWidth - (self.edgeOffset * 2) , height: self.height/2)
        
            self.fadeBackgroud.alpha = 0.5
            
        })
    }
}
