//
//  Parent.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/30/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class ParentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}

}

class ParentCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {}
}
