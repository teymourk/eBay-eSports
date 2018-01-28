//
//  BuyItem.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Buy_Filter: NSObject {
    
    internal enum Option {
        case Filter, Details, None
    }
    
    lazy var view = { () -> UIView in
        let view = UIView(frame: CGRect(x: edgeOffset, y: height, width: width - 40, height: cutomHeight))
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
    let cutomHeight = Constants.kHeight * (3.5/5)
    let edgeOffset: CGFloat = 10
    
    func openPageFor(_ Option: Option) {
        setupView()
        switch Option {
        case .Details:
            print("Details Page")
        case .Filter:
            print("Filter Page")
        default: break
        }
        
    }
    
    private func setupView() {
        window.addSubview(fadeBackgroud)
        window.addSubview(view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        
                        let y = (self.height) - (self.cutomHeight) - 10 //Needs to be Safelayout constant
                        self.view.frame = CGRect(x: self.edgeOffset, y: y, width: Constants.kWidth - (self.edgeOffset * 2) , height: self.cutomHeight)
                        self.fadeBackgroud.alpha = 0.5
                        
        })
    }
}
