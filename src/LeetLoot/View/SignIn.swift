//
//  SignIn.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol RegisterPagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}

class SignIn: ParentView {
    
    private let eliteLootLogo = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "EliteLootLogo"))
            image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var back = { () -> UIButton in
        let button = UIButton(imageName: "Back")
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.tag = 0
        return button
    }()
    
    private lazy var close = { () -> UIButton in
        let button = UIButton(imageName: "Close")
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.tag = 1
        return button
    }()
    
    private lazy var stackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [back, eliteLootLogo, close])
            stack.distribution = .fillProportionally
            stack.translatesAutoresizingMaskIntoConstraints = false
       return stack
    }()
    
    private let register = { () -> UIButton in
        let button = UIButton(title: "Register")
            button.setTitleColor(.lightBlue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = 2
        return button
    }()
    
    var delegate:RegisterPagesDelegate?
    
    @objc
    func onScreenButtons(_ sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.onScreenButtons(sender)
    }
    
    override func setupView() {
        backgroundColor = .white
        transform = CGAffineTransform(scaleX: 1, y: 1)
        
        addSubview(stackView)
        addSubview(register)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            register.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
