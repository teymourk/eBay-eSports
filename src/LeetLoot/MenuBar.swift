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
    
    enum Options: String {
        case Home, Browse
        
        static var menu = Menu.Options()
    
        var title: String { return self.rawValue }
        
        private init() {
            self = .Home
        }
    }
    
    var optionsCount: CGFloat {
        return CGFloat(stackView.subviews.count)
    }
    
    lazy var menuOptionsBar: UIView = {
        let view = UIView()
            view.backgroundColor = .blue
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var home = { () -> UIButton in
        let button = UIButton()
            button.setTitle(Options.Home.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(onMenuOptions(_:)), for: .touchUpInside)
            button.tag = 0
        return button
    }()
    
    lazy var browse = { () -> UIButton in
        let button = UIButton()
            button.setTitle(Options.Browse.title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15)
            button.addTarget(self, action: #selector(onMenuOptions(_:)), for: .touchUpInside)
            button.tag = 1
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
    
    var delegate: MenuBarDelegate?
    
    @objc
    private func onMenuOptions(_ sender: UIButton) {
        guard delegate != nil else {
            return
        }
        delegate?.onMenuButtons(sender)
    }
    
    private func setupLayoutContraints() {

        addSubview(menuOptionsBar)
        addSubview(stackView)
    
        NSLayoutConstraint.activate([
        
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            menuOptionsBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/optionsCount),
            menuOptionsBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.kWidth/optionsCount),
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
        backgroundColor = .white
    }
}
