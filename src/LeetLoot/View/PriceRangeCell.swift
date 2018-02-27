//
//  PriceRangeCell.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/26/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import RangeSeekSlider

class PriceRange: UITableViewCell {
    
    private lazy var priceSlider = { () -> RangeSeekSlider in
        let priceSlider = RangeSeekSlider()
            priceSlider.lineHeight = 2
            priceSlider.delegate = self
            priceSlider.translatesAutoresizingMaskIntoConstraints = false
        return priceSlider
    }()
    
    private func setupView() {
        addSubview(priceSlider)
        
        NSLayoutConstraint.activate([
            priceSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceSlider.topAnchor.constraint(equalTo: topAnchor, constant: 15),
        ])
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PriceRange: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return "$\(Int(minValue))"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        let value = Int(maxValue)
        return value == 100 ? "$\(value)+" : "$\(value)"
    }
}
