//
//  Merchendise.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

//Root of the API Call
struct Root:Codable, BrowseAPI, Equatable {
    static func ==(lhs: Root, rhs: Root) -> Bool {
        return  lhs.filterBy == rhs.filterBy &&
                lhs.sortBy == rhs.sortBy &&
                lhs.range == rhs.range
    }
    
    typealias Model = Root
    
    var total: Int?,
        itemHref: ItemHerf?,
        itemSummaries: [itemSummaries]?,
        keyWord: String?,
        filterBy: Filters.option?,
        sortBy: Sort.option?,
        fetchLimit: Int?,
        range: String?,
        errors: [errors]?

    init(queryKey: String, filterBy: Filters.option, sortBy: Sort.option, range: String? = nil, limit: Int? = nil) {
        self.keyWord = queryKey.replacingOccurrences(of: " ", with: "+")
        self.filterBy = filterBy
        self.sortBy = sortBy
        self.fetchLimit = limit
        self.range = range
    }
}

extension Array where Array == [Root] {
    var itemsSummary: [itemSummaries]? {
        return self.first?.itemSummaries
    }
}

//Root Constains and Array of all items with summaries
struct itemSummaries:Codable {
    private let itemId: String?,
                title: String?,
                itemWebUrl: String?,
                condition: String?,
                itemHref: String?,
                itemGroupHref: String?,
                price: price?,
                image: thumbnailImages?,
                thumbnailImages: [thumbnailImages]?,
                additionalImages: [thumbnailImages]?,
                shippingOptions: [shippingOptions]?
    
    var hrefURL: String? {
        get {
                let itemHrefURL = itemHref?.replacingOccurrences(of: "|", with: "%7C"), // | is not recognizes or converted as valid parameter
                    groupHrefURL = itemGroupHref
            return groupHrefURL != nil ? groupHrefURL : itemHrefURL
        }
    }
    
    var itemTitle: String {
        return title ?? "No Title Found"
    }
    
    var fullPrice: String {
        let price = "\(self.price?.currency ?? "Unknown Currency") $\(self.price?.value ?? "0.0")"
        return price
    }
    
    var imgURL: String {
        return self.image?.imageUrl ?? "Invalid URL"
    }

    var webURL: String {
        return self.itemWebUrl ?? "Invalid URL"
    }

    var shipping: String {
        return self.shippingOptions?.first?.shippingCostType == "CALCULATED" ? "+ Shipping" : "• Free Shipping"
    }
}

//Item Shipping
struct shippingOptions:Codable {
    let shippingCostType: String?
}

//Price
struct price:Codable {
    let value: String?,
        currency: String?
}

//Thumbnail Image
struct thumbnailImages:Codable {
    let imageUrl: String?
}

struct errors: Codable {
    let message: String?
}
