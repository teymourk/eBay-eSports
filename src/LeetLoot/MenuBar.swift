//
//  Menubar.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/29/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol MenuBarDelegate {
    func onMenuButtons(_ sender: UIButton)
}

final class Menu: UIView {

    //Menu Enum
    enum Options: String {
        case Home, Browse
        
        static var menu = Menu.Options() //Singleton
    
        var title: String { return self.rawValue }
        
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
    
    var delegate: MenuBarDelegate?
    private var isMenu: Bool = false
    
    //Stack view arrangedsubviews based on isMenu value
    private var options: [UIView] {
        return isMenu == true ? [UIView(), home, browse, UIView()] : [result, UIView(), UIView(), filtering]
    }
    
    private lazy var horizontalBar = { () -> UIView in
        let view = UIView()
            view.backgroundColor = .lightBlue
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var result = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.text = "215 Results"
            label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let home = { () -> CustomButton in
        let button = CustomButton(title: Menu.Options.Home.title)
            button.addTarget(self, action: #selector(onMenuOptions(_:)), for: .touchUpInside)
            button.tag = 0
        return button
    }()
    
    private var browse = { () -> CustomButton in
        let button = CustomButton(title: Menu.Options.Browse.title)
            button.addTarget(self, action: #selector(onMenuOptions(_:)), for: .touchUpInside)
            button.tag = 1
        return button
    }()
    
    private lazy var filtering = { () -> CustomButton in
        let button = CustomButton(title: "Filters",
                                  imageName: "Filters") //Needs To be a constant
            button.titleEdgeInsets.left = 10
            button.addTarget(self, action: #selector(onMenuOptions(_:)), for: .touchUpInside)
            button.tag = 2
        return button
    }()
    
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
        
        result.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        filtering.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(isMenu: Bool) {
        self.init(frame: .zero)
        self.isMenu = isMenu
        setupView()
        setupLayoutContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
    }
}
