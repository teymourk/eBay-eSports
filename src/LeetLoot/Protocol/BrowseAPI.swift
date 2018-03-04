//
//  BrowseAPI.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol BrowseAPI: Networking where Model == Root {
    var keyWord: String? { get set }
    var filterBy: Filters.option? { get set }
    var sortBy: Sort.option? { get set }
    var fetchLimit: Int? { get set }
    func retrieveDataByName(offset: Int, _ completion: @escaping ([Root]?) ->())
}

extension BrowseAPI {
    
    private var endPoint: String {
        let baseUrl = "https://api.ebay.com/buy/browse/v1/item_summary/search?",
            query = "q=\(keyWord ?? "")&",
            groupBy = "category_ids=\(filterBy?.rawValue ?? "")&",
            limit = "limit=\(fetchLimit ?? 30)&",
            buyOption = "buyingOptions%3A%7BFIXED_PRICE%7D",
            condition = "conditions%3A%7BNEW%7D&",
            filter = "filter=\(buyOption),\(condition)",
            sort = sortBy?.rawValue ?? ""
        return baseUrl + query + groupBy + limit + filter + sort
    }
    
    func retrieveDataByName(offset: Int, _ completion: @escaping ([Root]?) ->()) {
        guard let url = URL(string: endPoint+"&offset=\(offset)") else { return }
        
        print("URL: \(url)")
        
        var merchendise:[Root]? = [Root]()
        requestData(forUrl: url) { (_response, _merchendise) in
            switch _response {
            case let .error(errorDesctiption):
                print(errorDesctiption)
                completion(nil)
            case let .success(successDesctiption):
                guard   let merchObj = _merchendise else { return }
                    
                merchendise?.append(merchObj)
                DispatchQueue.main.async {
                    completion(merchendise)
                    print(successDesctiption)
                }
            }
        }
    }
}
