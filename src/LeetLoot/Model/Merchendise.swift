//
//  Merchendise.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


struct Root:Decodable, BrowseAPI {
    typealias Model = Root
    
    var total: Int?
    var itemSummaries: [itemSummaries]?
}

struct itemSummaries:Decodable {
    var itemId: String?
    var title: String?
    var itemWebUrl: String?
    var condition: String?
}
