//
//  ItemHerf.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/2/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


struct ItemHerf: Codable, Networking {
    typealias Model = ItemHerf
    
    var items: [items]?
    
    init?(herfUrl: String, completion: @escaping (ItemHerf) -> ()) {
        guard let url = URL(string: herfUrl) else { return }
        
        requestData(forUrl: url) { (_response, _itemHref) in
            DispatchQueue.main.async {
                completion(_itemHref!)
            }
        }
    }
}

struct items: Codable {
    var shortDescription: String?
    var image: thumbnailImages?
}
