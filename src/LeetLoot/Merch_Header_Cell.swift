//
//  h.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class Merch_Header_Cell: UICollectionViewCell {
    
    internal enum menu {
        case open,close
        
        static var state = menu() //Singleton
        
        mutating func adjustMenuHeigh() -> CGFloat  {
            return menu.state == .close ? 240 : 350
        }
        
        private init() {
            self = .close
        }
    }
    
    let colors: [UIColor] = [.red, .blue, .yellow]
    
    lazy var gameCarousel = { () -> UIScrollView in
        let scrollView = UIScrollView()
            scrollView.isPagingEnabled = true
            scrollView.contentSize.width = bounds.size.width * CGFloat(3)
            scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var pageControl = { () -> UIPageControl in
        let pageControl = UIPageControl()
            pageControl.numberOfPages = colors.count
            pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let topSeperator = { () -> UIView in
        let view = UIView()
            view.backgroundColor = .lightGray
        return view
    }()
    
    let bottomSeperator = { () -> UIView in
        let view = UIView()
            view.backgroundColor = .lightGray
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var openButton = { () -> UIButton in
        let button = UIButton()
            button.setImage(#imageLiteral(resourceName: "DownArrow"), for: .normal)
            button.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        return button
    }()
    
    let filteringIcon = { () -> UIImageView in
        let image = UIImageView()
            image.image = UIImage(named: "Sorting") //Need Constant
        return image
    }()
    
    lazy var menuTitle = { () -> UILabel in
        let label = UILabel()
            label.text = "Sort & Filter" //Need Constant
            label.textColor = .black
        return label
    }()
    
    //Vertical Stack for scrollView and first seperator
    lazy var topStackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [gameCarousel, topSeperator])
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //Horizontal Stack for The menubar icons
    lazy var bottomStackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [filteringIcon, menuTitle, openButton])
            stack.alignment = .center
            stack.distribution = .equalCentering
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var browse_game: Browse_Game?
    
    @objc
    private func onButton(_ sender: UIButton) {
        handleMenuFunctionality(sender)
    }

    private func handleMenuFunctionality(_ sender: UIButton) {
        menu.state = menu.state == .close ? .open : .close
        let buttonImage = menu.state == .close ? #imageLiteral(resourceName: "DownArrow") : #imageLiteral(resourceName: "UpArrow")
        guard browse_game != nil else { return  }
        sender.setImage(buttonImage, for: .normal)
        UIView.animate(withDuration: 0.5, animations: {
            self.browse_game?.collectionViewLayout.invalidateLayout()
            self.browse_game?.view.layoutIfNeeded()
        })
    }
    
    private func setupLayoutContraints() {
        addSubview(topStackView)
        addSubview(pageControl)
        addSubview(bottomStackView)
        addSubview(bottomSeperator)
        
        NSLayoutConstraint.activate([
            
            topStackView.topAnchor.constraint(equalTo: topAnchor),
            topStackView.heightAnchor.constraint(equalToConstant: 200),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: -5),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            bottomStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            bottomStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bottomStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5),
            
            bottomSeperator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeperator.heightAnchor.constraint(equalToConstant: 0.5),
            bottomSeperator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeperator.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupView() {
        setupLayoutContraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayoutContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
