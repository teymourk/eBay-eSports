//
//  Menubar.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/29/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol MenuBarDelegate: class {
    func onMenuButtons(_ sender: UIButton)
}

final class Menu: ParentView {
    
    var results: Int? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.result.text = "\(self?.results ?? 0) Results"
            }
        }
    }

    //Menu Enum
    internal enum Options: String {
        case Home, Browse, Filters, Results
        
        static var menu = Menu.Options() //Singleton
        
        private init() {
            self = .Home
        }
    }
    
    //Number of Option in the Menu
    var optionsCount: CGFloat {
        return CGFloat(stackView.subviews.count)
    }
    
    //Variable for changing the horizontal bar x value
    var barConstant: CGFloat {
        get {
            return horizontalBar.frame.origin.x
        } set(newValue) {
            horizontalBar.frame.origin.x = newValue
        }
    }
    
    weak var delegate: MenuBarDelegate?
    private var isMenu: Bool = false
    
    //Stack view arrangedsubviews based on isMenu value
    private var options: [UIView] {
        return isMenu == true ? [UIView(), menuButton.Home, menuButton.Browse, UIView()] :
                                [result, UIView(), UIView(), menuButton.Fitler]
    }
    
    private let horizontalBar = { () -> UIView in
        let view = UIView()
            view.backgroundColor = .lightBlue
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let result = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.textAlignment = .right
            label.font = .systemFont(ofSize: 15)
        return label
    }()
            
    private var menuButton: (   Home:UIButton,
                                Browse:UIButton,
                                Fitler:UIButton) {
    
        let button = createButtons(.Home,
                                   .Browse,
                                   .Filters)
        
        return (button[0], //Return Home
                button[1], //Return Browse
                button[2]) //Return Filters
    }

    //Create Multiple buttoms of same attributes
    private func createButtons(_ buttonTitle: Options...) -> [UIButton] {
        return buttonTitle.enumerated().map({ (index,name) in
            let title = name.rawValue
            let button = UIButton(title: title, imageName: UIImage(named: title))
                button.addTarget(self, action: #selector(onMenuOptions(_ :)), for: .touchUpInside)
                button.titleEdgeInsets.left = buttonTitle[index] == .Filters ? 10 : 0
                button.tag = index
                button.translatesAutoresizingMaskIntoConstraints = false
            return button
        })
    }
    
    private lazy var stackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: options)
            stack.distribution = .fillEqually
            stack.alignment = .center
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    @objc
    private func onMenuOptions(_ sender: UIButton) {
        guard delegate != nil else {
            return
        }
        delegate?.onMenuButtons(sender)
    }
    
    private func setupLayoutContraints() {
        addSubview(stackView)
        addSubview(horizontalBar)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            horizontalBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalBar.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        //It anchors the horizontal bar based on if isMenu
        if isMenu {
            horizontalBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/optionsCount).isActive = true
            horizontalBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.kWidth/optionsCount).isActive = true
            return
        }
        horizontalBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        horizontalBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    convenience init(isMenu: Bool) {
        self.init(frame: .zero)
        self.isMenu = isMenu
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupLayoutContraints()
    }
}
