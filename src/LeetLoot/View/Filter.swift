//
//  Filter.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Filter: UITableView {
        
    var sorting: Sort.option = .Best_Match,
        filtering: Filters.option = .All_Items,
        rangeQuery: String = "0.."

    private var rootQuery: Root?
    
    var filterQuery: Root? {
        get {
            let name = self.rootQuery?.keyWord ?? ""
            rootQuery = Root(queryKey: name, filterBy: filtering, sortBy: sorting, range: rangeQuery)
            return rootQuery
            
        }set {
            self.rootQuery = newValue
        }
    }

    fileprivate var filterMenu: [FilterOptions] {
        return [Sort(), Filters(), Price()]
    }
    
    private func setupTableView() {
        backgroundColor = .white
        register(Filter_Cell.self, forCellReuseIdentifier: "FilterCell")
        register(PriceRange.self, forCellReuseIdentifier: "T")
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        delegate = self
        dataSource = self
        bounces = false
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: .plain)
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(onResetFilter), name: NSNotification.Name(rawValue: "onResetFilter"), object: nil) //Need To deinit this 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onResetFilter() {
        sortCheckedIndexPath = IndexPath(item: 0, section: 0)
        filterCheckedIndexPth = IndexPath(item: 0, section: 1)
        sorting = .Best_Match
        filtering = .All_Items
        rangeQuery = "0.."
        reloadData()
    }
    
    //Will Make Dynamic later
    var sortCheckedIndexPath: IndexPath? = IndexPath(item: 0, section: 0)
    var filterCheckedIndexPth: IndexPath? = IndexPath(item: 0, section: 1)
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
            let priceCell = tableView.dequeueReusableCell(withIdentifier: "T", for: indexPath) as? PriceRange
                priceCell?.selectionStyle = .none
                priceCell?.delegate = self
            return priceCell ?? UITableViewCell()
        }
        
        let filtersCell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? Filter_Cell
        let options = filterMenu[indexPath.section].options[indexPath.row]
        filtersCell?.textLabel?.text = options.name
        filtersCell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        filtersCell?.selectionStyle = .none
        filtersCell?.checkImage.isHidden =  indexPath == sortCheckedIndexPath ||
                                            indexPath == filterCheckedIndexPth ? false : true
        filtersCell?.textLabel?.textColor = indexPath == sortCheckedIndexPath ||
                                            indexPath == filterCheckedIndexPth ? .lightBlue : .black
    
        return filtersCell ?? UITableViewCell()
    }
    
    fileprivate func menuOptions<T>(indexPath: IndexPath) -> T {
        let item =  filterMenu[indexPath.section]
                    .options[indexPath.item] as? T
        
        return item!
    }
    
    //Will Refactor This...ITS for testing purposes only
    func handleFilterChanging(indexPath: IndexPath, tableView: UITableView) {
    
        if indexPath.section == 0 {
            if sortCheckedIndexPath != nil {
                let cell = tableView.cellForRow(at: sortCheckedIndexPath!) as? Filter_Cell
                    cell?.checkImage.isHidden = true
                    cell?.textLabel?.textColor = .black
            }
            sortCheckedIndexPath = indexPath
            let cell = tableView.cellForRow(at: indexPath) as? Filter_Cell
                cell?.checkImage.isHidden = false
                cell?.textLabel?.textColor = .lightBlue
            return
        }
        
        if indexPath.section == 1 {
            if filterCheckedIndexPth != nil {
                let cell = tableView.cellForRow(at: filterCheckedIndexPth!) as? Filter_Cell
                    cell?.checkImage.isHidden = true
                    cell?.textLabel?.textColor = .black
            }
            filterCheckedIndexPth = indexPath
            let cell = tableView.cellForRow(at: indexPath) as? Filter_Cell
                cell?.checkImage.isHidden = false
                cell?.textLabel?.textColor = .lightBlue
            return
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0: sorting = menuOptions(indexPath: indexPath)
            case 1: filtering = menuOptions(indexPath: indexPath)
        default: return }
        
        handleFilterChanging(indexPath: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Header_Cell()
            view.backgroundColor = .customGray
            view.title = filterMenu[section].sectionTitle
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 2 ? customHeight.PriceRange : customHeight.Header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return customHeight.Header
    }
}

//Mark: PriceRangeDelegate
extension Filter: priceRangeDelegate {
    func onPriceRange(min: Int, max: Int) {
        if min < 100, max == 100 {
            rangeQuery = "\(min).."
            return
        }
        if min > 0, max < 100 {
            rangeQuery = "\(min)..\(max)"
            return
        }
        if min == 0, max < 100 {
            rangeQuery = "\(0)..\(max)"
            return
        }
    }
}

