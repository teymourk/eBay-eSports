//
//  PriceRangeCell.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/26/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol priceRangeDelegate: class {
    func onPriceRange(min: Int, max: Int)
}

class PriceRange: UITableViewCell {
    
    private lazy var priceSlider = { () -> RangeSeekSlider in
        let priceSlider = RangeSeekSlider()
            priceSlider.lineHeight = 2
            priceSlider.handleBorderWidth = 0.5
            priceSlider.colorBetweenHandles = .lightBlue
            priceSlider.handleBorderColor = .lightBlue
            priceSlider.handleColor = .white
            priceSlider.delegate = self
            priceSlider.translatesAutoresizingMaskIntoConstraints = false
        return priceSlider
    }()
    
    weak var delegate: priceRangeDelegate?

    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(onResetFilter), name: NSNotification.Name(rawValue: "onResetFilter"), object: nil) //Need To deinit this 
        
        addSubview(priceSlider)
        
        NSLayoutConstraint.activate([
            priceSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceSlider.topAnchor.constraint(equalTo: topAnchor, constant: 10),
        ])
    }
    
    @objc
    private func onResetFilter() {
        let minValue = priceSlider.selectedMinValue,
            maxValue = priceSlider.selectedMaxValue
        
        if minValue != 0 || maxValue != 100 {
            priceSlider.selectedMinValue = 0
            priceSlider.selectedMaxValue = 100
            priceSlider.layoutSubviews()
        }
    }
    
    deinit {
        print("Im leaving")
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
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        delegate?.onPriceRange(min: Int(minValue), max: Int(maxValue))
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return "$\(Int(minValue))"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        let value = Int(maxValue)
        return value == 100 ? "$\(value)+" : "$\(value)"
    }
}
