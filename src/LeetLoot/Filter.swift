//
//  Filter.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/1/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Filter: UITableView {
    
    fileprivate var filterMenu: Dictionary<String, Any> {
        return ["Sory by": sort.self,
                "Item Type": itemType.self,
                "Price": CGFloat()]
    }
    
    private enum sort {
        case Relevance, Rating, All, Toys, Clothing
    }
    
    private enum itemType {
        case  All, Toys, Clothing
    }
    
    private func setupTableView() {
        backgroundColor = .white
        register(Filter_Cell.self, forCellReuseIdentifier: "FilterCell")
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
        return filterMenu.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? Filter_Cell
        return cell ?? UITableViewCell()
    }
}


