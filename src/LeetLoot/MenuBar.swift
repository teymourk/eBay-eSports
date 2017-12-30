//
//  Menubar.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/29/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    enum MenuOptions: String {
        case Home, Browse
        
        var title: String {
            return self.rawValue
        }
    }
    
    lazy var menuOptionsBar: UIView = {
        let view = UIView()
            view.backgroundColor = .lightGray
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var home = { () -> UIButton in
        let button = UIButton()
            button.setTitle(MenuOptions.Home.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    var browse = { () -> UIButton in
        let button = UIButton()
            button.setTitle(MenuOptions.Browse.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    lazy var stackView = { () -> UIStackView in
        let blankViwe1 = UIView() //Using these blanck views to
        let blankView4 = UIView() //evenly distribute the stackview
        let stack = UIStackView(arrangedSubviews: [blankViwe1,home,browse,blankView4])
            stack.distribution = .fillEqually
            stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var leftAncharConstraint: NSLayoutConstraint?
    
    private func setupLayoutContraints() {
        addSubview(menuOptionsBar)
        addSubview(stackView)
        
        leftAncharConstraint = menuOptionsBar.leftAnchor.constraint(equalTo: leftAnchor)
        leftAncharConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            menuOptionsBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            menuOptionsBar.heightAnchor.constraint(equalToConstant: 3),
            menuOptionsBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayoutContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .yellow
    }
}
