//
//  Filter.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Filter: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

