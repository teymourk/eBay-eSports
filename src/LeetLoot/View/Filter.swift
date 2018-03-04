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
        self.isScrollEnabled = false
        self.showsVerticalScrollIndicator = false
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
    
    private var customHeight: (Header: CGFloat, PriceRange: CGFloat) {
        guard   let parentHeight = superview?.frame.height else { return (40, 40) }
                let ratioaBasedOnDevice:CGFloat = Constants.isDevice == .X ? 12.5 : 13.0
                let optionsHeight = CGFloat(parentHeight / ratioaBasedOnDevice)
                let priceRangeHeight = CGFloat(parentHeight - (optionsHeight * 11) + 10)
        return (optionsHeight, priceRangeHeight)
    }

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
        
        cell?.textLabel?.text = options.name
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
            view.backgroundColor = .customGray
            view.title = filterMenu[section].sectionTitle
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return customHeight.PriceRange
        }
        return customHeight.Header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customHeight.Header
    }
}

