//
//  BuyItem.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/17/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol BuyFilterDelegate: class {
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
    
    private var menuOption: Option = .None
    
    private lazy var parentView = { () -> UIView in
        let view = UIView(frame: customFrame(height))
            view.backgroundColor = .white
        return view
    }()
    
    private lazy var fadeBackgroud = { () -> UIView in
        let view = UIView(frame: window.frame)
            view.backgroundColor = .black
            view.alpha = 0
        return view
    }()
    
    private lazy var close_done = { () -> UIButton in
        let button = UIButton(imageName: #imageLiteral(resourceName: "DownArrow"))
            button.addTarget(self, action: #selector(onClose_Done(_ :)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buy_reset = { () -> UIButton in
        let button = UIButton()
            button.backgroundColor = .lightBlue
            button.layer.cornerRadius = 4
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
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
        return view
    }()
    
    weak var delegate: BuyFilterDelegate?
    
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
        
        let title = $0 == .Filter ? "RESET" : "BUY NOW"
        self.buy_reset.setTitle(title, for: .normal)
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
        
        menuOption = view
    }
    
    private func setupViewFor(_ currentView: UIView) -> UIView {
        currentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(close_done)
        parentView.addSubview(buy_reset)
        parentView.addSubview(currentView)
        NSLayoutConstraint.activate([
            close_done.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 10),
            close_done.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            
            buy_reset.heightAnchor.constraint(equalToConstant: 40),
            buy_reset.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -5),
            buy_reset.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 5),
            buy_reset.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -5),
            
            currentView.topAnchor.constraint(equalTo: close_done.bottomAnchor, constant: 10),
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
                        [pView = self.parentView, bView = self.fadeBackgroud, cFrame = self.customFrame] in
                pView.frame = cFrame(self.height)
                bView.alpha = 0
        }, completion: { [weak self] (true) in
            self?.parentView.removeFromSuperview()
            self?.fadeBackgroud.removeFromSuperview()
            self?.currentView.removeFromSuperview()
        })
    }
    
    @objc
    private func onClose_Done(_ sender: UIButton) {
        switch menuOption {
        case .Buy:
            close()
        case .Filter:
            close()
            delegate?.updateNewData(for: filterView.rootQuery)
        case .None: break
        }
    }
    
    @objc
    private func onBuy_Reset(_ sender: UIButton) {
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
