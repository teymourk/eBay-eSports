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
    private var frame: CGRect {
        return CGRect(x: edgeOffset, y: height, width: width - 40, height: cutomHeight)
    }
    
    private lazy var buyView = { () -> Buy in
        let view = Buy(frame: frame)
            view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var filterView = { () -> Filter in
        let view = Filter(frame: frame)
            view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var fadeBackgroud = { ()-> UIView in
        let view = UIView(frame: Constants.kWindow.frame)
            view.backgroundColor = .black
            view.alpha = 0
        return view
    }()
    
    private let (width, height, window, cutomHeight) = (Constants.kWidth,
                                                        Constants.kHeight,
                                                        Constants.kWindow,
                                                        Constants.kHeight * (3.5/5))

    private let edgeOffset: CGFloat = 10
    
    func openPageFor(_ Option: Option) {
        Option == .Details ? setupViewFor(buyView) : setupViewFor(filterView)
    }
    
    private func setupViewFor(_ view: UIView) {
        window.addSubview(fadeBackgroud)
        window.addSubview(view)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        
            let y = (self.height) - (self.cutomHeight) - 10 //Needs to be Safelayout constant
            view.frame = CGRect(x: self.edgeOffset, y: y, width: Constants.kWidth - (self.edgeOffset * 2) , height: self.cutomHeight)
            self.fadeBackgroud.alpha = 0.5
        })
    }
}
