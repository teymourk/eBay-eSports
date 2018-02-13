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
    var groupingBy: Type.option? { get set }
    func searchByKeyWord(_ completion: @escaping ([Root]?) ->())
}

extension BrowseAPI {
    private var endPoint: URL? {
        let baseUrl = "https://api.ebay.com/buy/browse/v1/item_summary/search?"
        let query = "q=\(keyWord ?? "")&"
        let groupBy = "category_ids=\(groupingBy?.rawValue ?? "")&"
        let limit = "limit=30"
        return URL(string: baseUrl + query + groupBy + limit)
    }
    
    func searchByKeyWord(_ completion: @escaping ([Root]?) ->()) {
        guard let url = endPoint else { return }
        print(url)
        var merchendise:[Root]? = [Root]()
        requestData(forUrl: url) { (_response, _merchendise) in
            switch _response {
            case let .error(errorDesctiption):
                print(errorDesctiption)
                completion(nil)
            case let .success(successDesctiption):
                guard let merchObj = _merchendise else { return }
                merchendise?.append(merchObj)
                DispatchQueue.main.async {
                    completion(merchendise)
                    print(successDesctiption)
                }
            }
        }
    }
}

//Group ID
//220 Toys
//1059 T-shirts
