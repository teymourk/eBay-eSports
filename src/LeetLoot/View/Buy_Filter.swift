//
//  BuyItem.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol BuyFilterDelegate {
    func updateNewData(for query: Root)
}

final class Buy_Filter: NSObject {
    
    internal var items: (summary: itemSummaries?, href: ItemHerf?) {
        didSet {
            buyView.items = items
            open(.Buy)
        }
    }

    internal enum Option {
        case Filter, Buy, None
    }
    
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
    
    let downArrow = { () -> UIImageView in
        let image = UIImageView(image:  #imageLiteral(resourceName: "DownArrow"))
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var buy_reset = { () -> UIButton in
        let button = UIButton()
            button.addTarget(self, action: #selector(onBuy_Reset(_ :)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buyView = { () -> Buy in
        let view = Buy()
        return view
    }()
    
    private lazy var filterView = { () -> Filter in
        let view = Filter()
            view.filteringDelegate = self
        return view
    }()
    
    var delegate: BuyFilterDelegate?
    
    private lazy var customFrame: (CGFloat) -> CGRect = {
        return CGRect(x: self.edgeOffset,
                      y: $0,
                      width: self.width - (self.edgeOffset * 2),
                      height: self.cutomHeight)
    }
    
    private var currentView = UIView()
    private let edgeOffset: CGFloat = 10.0
    
    private let (width, height, window, cutomHeight) = (Constants.kWidth,
                                                                Constants.kHeight,
                                                                Constants.kWindow,
                                                                Constants.kHeight * (3.7/5))
    
    private var bottomOffset: CGFloat {
        get { return Constants.isDevice == .X ? 40 : 10 }
    }
    
    private lazy var setupOptions: (Option) -> () = {
        let image = $0 == .Filter ? "Reset" : "BuyNow"
        self.buy_reset.setImage(UIImage(named: image), for: .normal)
        self.currentView = $0 == .Buy ? self.setupViewFor(self.buyView) : self.setupViewFor(self.filterView)
    }
    
    func open(_ view: Option) {
        window.addSubview(fadeBackgroud)
        window.addSubview(parentView)
        
        parentView.layer.cornerRadius = 5
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        
                let y = (self.height) - (self.cutomHeight) - self.bottomOffset
                self.parentView.frame = self.customFrame(y)
                self.fadeBackgroud.alpha = 0.5
                self.setupOptions(view)
        })
    }
    
    private func setupViewFor(_ currentView: UIView) -> UIView {
        currentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(downArrow)
        parentView.addSubview(buy_reset)
        parentView.addSubview(currentView)
        NSLayoutConstraint.activate([
            downArrow.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 10),
            downArrow.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            buy_reset.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -5),
            buy_reset.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 5),
            buy_reset.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -5),
            
            currentView.topAnchor.constraint(equalTo: downArrow.bottomAnchor, constant: 10),
            currentView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    
        if currentView == filterView {
            currentView.bottomAnchor.constraint(equalTo: buy_reset.topAnchor, constant: -10).isActive = true
        }
        
        return currentView
    }
    
    private func close() {
        UIView.animate(withDuration: 0.2,
                       delay: 0, options: .curveEaseIn, animations: {
                self.parentView.frame = self.customFrame(self.height)
                self.fadeBackgroud.alpha = 0
        }, completion: { (true) in
            self.parentView.removeFromSuperview()
            self.fadeBackgroud.removeFromSuperview()
            self.currentView.removeFromSuperview()
        })
    }
    
    @objc private func onBuy_Reset(_ sender: UIButton) {
        guard let itemUrl = URL(string: items.summary?.webURL ?? "") else { return }
        
        if UIApplication.shared.canOpenURL(itemUrl) {
            UIApplication.shared.open(itemUrl, options: [:], completionHandler: nil)
            return
        }
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

//Filtering MenuDelegate
extension Buy_Filter: FilterMenuDelegate {
    func selctedQuery(_ query: Root) {
        close()
        guard delegate != nil else { return }
        self.delegate?.updateNewData(for: query)
    }
}
