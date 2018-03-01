//
//  Merchendise.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

//Root of the API Call
struct Root:Codable, BrowseAPI {    
    typealias Model = Root
    
    var total: Int?
    var itemSummaries: [itemSummaries]?
    
    //It counts it in the Decode ? Anyways to not without using
    //Customization
    var keyWord: String?
    var filterBy: Filters.option?
    var sortBy: Sort.option?
    var fetchLimit: Int?
    
    init(queryKey: String, filterBy: Filters.option, sortBy: Sort.option, limit: Int? = nil) {
        self.keyWord = queryKey
        self.filterBy = filterBy
        self.sortBy = sortBy
        self.fetchLimit = limit
    }
}

//Root Constains and Array of all items with summaries
struct itemSummaries:Codable {
    var itemId: String?
    var title: String?
    var itemWebUrl: String?
    var condition: String?
    var price: price?
    var thumbnailImages: [thumbnailImages]?
    var additionalImages: [thumbnailImages]?
    var shippingOptions: [shippingOptions]?
    
}
//Item Shipping
struct shippingOptions:Codable {
    var shippingCostType: String?
}

//Price
struct price:Codable {
    var value: String?
    var currency: String?
}

//Thumbnail Image
struct thumbnailImages:Codable {
    var imageUrl: String?
}
