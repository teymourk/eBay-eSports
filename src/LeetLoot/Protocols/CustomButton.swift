//
//  CustomButton.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/22/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


protocol CustomButton {}

extension CustomButton where Self: UIButton {
     init(title: Menu.Options, imageName: String? = nil) {
        self.init(frame: .zero)
        let image = imageName == nil ? nil : UIImage(named: imageName!)
        setTitle(title.title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
        setImage(image, for: .normal)
        setTitleColor(.darkText , for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton: CustomButton {}
