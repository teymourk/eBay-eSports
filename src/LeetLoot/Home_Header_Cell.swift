//
//  Home_Header_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class Header_Cell: ParentCell {

    var title: String?{
        didSet {
            sectionTitle.text = title != nil ? title : ""
        }
    }
    
    private let sectionTitle = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 15)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupView() {
        backgroundColor = .customGray
        setupHeaderTitle()
    }
    private func setupHeaderTitle() {
        addSubview(sectionTitle)

        NSLayoutConstraint.activate([
            sectionTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sectionTitle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
