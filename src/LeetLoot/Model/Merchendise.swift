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
    var next: String?
    var itemSummaries: [itemSummaries]?
    
    //It counts it in the Decode ? Anyways to not without using
    //Customization
    var keyWord: String?
    var groupingBy: Type.option?
    
    init(queryKey: String, groupBy: Type.option) {
        self.keyWord = queryKey
        self.groupingBy = groupBy
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
    
    var additionalImages: [additionalImages]?
}

//Additional Images
struct additionalImages:Codable {
    var imageUrl: String?
}
