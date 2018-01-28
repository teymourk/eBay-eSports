//
//  BuyItem.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Buy_Filter: NSObject {
    
    private lazy var parentView = { ()-> UIView in
        let view = UIView(frame: customFrame(height))
            view.backgroundColor = .white
        return view
    }()
    
    private lazy var fadeBackgroud = { ()-> UIView in
        let view = UIView(frame: window.frame)
            view.backgroundColor = .black
            view.alpha = 0
        return view
    }()
    
    let stackView = { () -> UIStackView in
        let view = UIView()
            view.backgroundColor = .red
        let view1 = UIView()
            view1.backgroundColor = .yellow
        let view2 = UIView()
            view2.backgroundColor = .blue
        let stack = UIStackView(arrangedSubviews: [view,view1,view2])
            stack.distribution = .fillEqually
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    internal enum Option {
        case Filter, Buy, None
    }
    
    private lazy var customFrame: (CGFloat) -> CGRect = {
        return CGRect(x: self.edgeOffset,
                      y: $0,
                      width: self.width - (self.edgeOffset * 2),
                      height: self.cutomHeight)
    }
    
    private let buyView = { () -> Buy in
        let view = Buy()
        return view
    }()
    
    private let filterView = { () -> Filter in
        let view = Filter()
        return view
    }()
    
    private let (width, height, window, cutomHeight, device) = (Constants.kWidth,
                                                                Constants.kHeight,
                                                                Constants.kWindow,
                                                                Constants.kHeight * (3.5/5),
                                                                Constants.deviceType.None.isDevice())
    private let edgeOffset: CGFloat = 10.0
    
    private var bottomOffset: CGFloat {
        get { return device == .X ? 40 : 10 }
    }
    
    func open(_ view: Option) {
        window.addSubview(fadeBackgroud)
        window.addSubview(parentView)
        
        parentView.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        
            let y = (self.height) - (self.cutomHeight) - self.bottomOffset
            self.parentView.frame = self.customFrame(y)
            self.fadeBackgroud.alpha = 0.5
            view == .Buy ? self.setupViewFor(self.buyView) : self.setupViewFor(self.filterView)
        })
    }
    
    private func setupViewFor(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(stackView)
        parentView.addSubview(view)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            
            view.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
    private func close() {
        UIView.animate(withDuration: 0.2,
                       delay: 0, options: .curveEaseIn, animations: {

                self.parentView.frame = self.customFrame(self.height)
                self.fadeBackgroud.alpha = 0
        }, completion: { (true) in
            self.parentView.removeFromSuperview()
            self.fadeBackgroud.removeFromSuperview()
        })
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_: )))
            tapGesture.numberOfTapsRequired = 1
        fadeBackgroud.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func onTap(_ sender: UITapGestureRecognizer) {
        parentView.isDescendant(of: window) ? close() : nil
    }
    
    override init() {
        super.init()
        setupGesture()
    }
}
