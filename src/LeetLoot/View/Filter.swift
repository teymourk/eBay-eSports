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
        self.delegate = self
        self.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? Filter_Cell
        let options = filterMenu[indexPath.section].options[indexPath.row]
        
        cell?.textLabel?.text = options.title
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let sort = filterMenu[0].options[indexPath.item] as? Sort.option else { return }
            sorting = sort
        case 1:
            guard let filter = filterMenu[1].options[indexPath.item] as? Filters.option else { return }
            filtering = filter
        default: break
        }
        
        let query = Root(queryKey: "League+of+legends", filterBy: filtering, sortBy: sorting)
        filteringDelegate?.selctedQuery(query)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Header_Cell()
        view.title = filterMenu[section].sectionTitle
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
