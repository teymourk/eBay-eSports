//
//  Filter.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol FilterMenuDelegate {

}

class Filter: UITableView {
    fileprivate var filterMenu: [FilterOptions] {
        return [Sort(), Type(), Price()]
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
     
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOptions = filterMenu[indexPath.section].options[indexPath.item]
        
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


