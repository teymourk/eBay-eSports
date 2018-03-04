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
    
    var shortDescription: String?,
        image: thumbnailImages?,
        items: [items]?
    
    init?(herfUrl: String, completion: @escaping (ItemHerf) -> ()) {
        guard let url = URL(string: herfUrl) else { return }
        
        requestData(forUrl: url) { (_response, _itemHref) in
            guard let itemHref = _itemHref else { return }
            DispatchQueue.main.async {
                completion(itemHref)
            }
        }
    }
    
    var description: String {
        let groupHrefDescription = self.items?.first?.shortDescription,
            itemsHrefDescription = self.shortDescription
        return groupHrefDescription != nil ? groupHrefDescription ?? "" : itemsHrefDescription ?? ""
    }
    
    var imgURL: String {
        let groupHrefImage = self.items?.first?.primaryItemGroup?.itemGroupImage?.imageUrl,
            itemsHrefImage = self.image?.imageUrl
        return groupHrefImage != nil ? groupHrefImage ?? "" : itemsHrefImage ?? ""
    }
}

struct items: Codable {
    let primaryItemGroup: primaryItemGroup?,
        shortDescription: String?

}

struct primaryItemGroup: Codable {
    let itemGroupImage: thumbnailImages?
}
