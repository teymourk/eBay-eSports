//
//  Filter.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol FilterMenuDelegate {
    func selctedQuery(_ query: Root)
}

class Filter: UITableView {
    
    var sorting: Sort.option = .Best_Match
    var filtering: Filters.option = .All_Items
    
    var filteringDelegate: FilterMenuDelegate?
    
    fileprivate var filterMenu: [FilterOptions] {
        return [Sort(), Filters(), Price()]
    }
    
    private func setupTableView() {
        backgroundColor = .white
        register(Filter_Cell.self, forCellReuseIdentifier: "FilterCell")
        register(PriceRange.self, forCellReuseIdentifier: "T")
        self.delegate = self
        self.dataSource = self
        self.bounces = false
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//Mark: -TableView DataSource/Delegate
extension Filter: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filterMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMenu[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "T", for: indexPath) as? PriceRange
                cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? Filter_Cell
        let options = filterMenu[indexPath.section].options[indexPath.row]
        
        cell?.textLabel?.text = options.title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell ?? UITableViewCell()
    }
    
    fileprivate func menuOptions<T>(indexPath: IndexPath) -> T {
        let item =  filterMenu[indexPath.section]
                    .options[indexPath.item] as? T
        return item!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0: sorting = menuOptions(indexPath: indexPath)
            case 1: filtering = menuOptions(indexPath: indexPath)
        default: return }
        
        let query = Root(queryKey: "League+of+legends", filterBy: filtering, sortBy: sorting)
        filteringDelegate?.selctedQuery(query)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Header_Cell()
            view.title = filterMenu[section].sectionTitle
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 100
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

import WARangeSlider

class PriceRange: UITableViewCell {
    
    let minValue = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.text = "0"
            label.font = UIFont.systemFont(ofSize: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let maxValue = { () -> UILabel in
        let label = UILabel()
            label.textColor = .black
            label.text = "100"
            label.font = UIFont.systemFont(ofSize: 13)
            label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceSlider = { () -> RangeSlider in
        let priceSlider = RangeSlider(frame: CGRect(x: 15, y: 30, width: frame.width, height: 20))
            priceSlider.minimumValue = 0
            priceSlider.maximumValue = 100
            priceSlider.lowerValue = 0
            priceSlider.upperValue = 100
            priceSlider.trackHighlightTintColor = .lightBlue
            priceSlider.thumbBorderColor = .white
            priceSlider.thumbBorderColor = .lightGray
            priceSlider.addTarget(self, action: #selector(onSlider(_:)), for: .valueChanged)
        return priceSlider
    }()
    
    private func setupView() {
        addSubview(priceSlider)
        addSubview(minValue)
        addSubview(maxValue)
        
        NSLayoutConstraint.activate([
            minValue.topAnchor.constraint(equalTo: priceSlider.bottomAnchor, constant: 10),
            minValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            maxValue.topAnchor.constraint(equalTo: minValue.topAnchor),
            maxValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    @objc
    private func onSlider(_ slider: RangeSlider) {
        let lowValue = Int(slider.lowerValue),
            highValue = Int(slider.upperValue)
        
        minValue.text = "\(lowValue)"
        maxValue.text = "\(highValue)"

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
