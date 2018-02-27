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
    func retrieveDataByName(offset: Int, _ completion: @escaping ([Root]?) ->())
}

extension BrowseAPI {
    private var token: String {
        return "v^1.1#i^1#p^1#f^0#I^3#r^0#t^H4sIAAAAAAAAAOVXa2wUVRTu9GUawBolIKSBZZAYwZmd1+5OR3aTLdtKpS+6taElpLk7c6cdujuzzL1Ld0W0FIJWpMEfmkBESAwxDZAISmKNRAiJkYCokFiihBAlxkdsQtAQfiDemV3KthKeRUjcP5s599xzv+87j5nL9ZaWzd+4eOOlKdQjhTt7ud5CiuIncWWlJQseLSqcWVLA5TlQO3uf6i3uK/plIQKJeFJphihpmQh60om4iRTXGKRTtqlYABlIMUECIgWrSjRcX6cILKckbQtbqhWnPbWRIB2TeZ/mF3Vd9muCLHDEal6L2WIFaVGV/T6dBzGfqoma6iPrCKVgrYkwMHGQFjheZjiBEQItXECRBEWQWH9AbKc9rdBGhmUSF5ajQy5cxd1r52G9OVSAELQxCUKHasM10cZwbaS6oWWhNy9WKKdDFAOcQmOfFlka9LSCeAre/BjkeivRlKpChGhvKHvC2KBK+BqYu4DvSu0DAVmGUOYqYz4/D/UJkbLGshMA3xyHYzE0RnddFWhiA2dupShRI7YSqjj31EBC1EY8zt/SFIgbugHtIF1dFW4LNzXRoSUGsAHqamHqIMR1loWZpuYIE+BFCcp6QGA0QRX9csyfOygbLSfzuJMWWaZmOKIhT4OFqyBBDcdrI+ZpQ5wazUY7rGMHUb5f5TUN/VK7k9RsFlO4y3TyChNECI/7eOsMjO7G2DZiKQxHI4xfcCUK0iCZNDR6/KJbi7nySaMg3YVxUvF6e3p62B6RtexOr8BxvHdZfV1U7YIJQBNfp9ez/satNzCGS0WFZCcyFJxJEixpUqsEgNlJhwS/TxR9Od3HwgqNt/7LkMfZO7YjJqpDxADgdV2SJFUCnKxKE9EhoVyReh0cMAYyTALY3RAn40CFjErqLJWAtqEpok8XRFmHjOav1BmpUteZGBmNDK9DyEEYi6mV8v+pUW631KOqlYRNVtxQMxNS8BNW7KKtNQEbZ6IwHieG2636G5JEDsn7Ts/p9Tui6MRAJAhIGqxT26xqJbwWIEPNMXW4qO+Jt0Hehw9VUgnBLFNDy77IWJcui1arrA2RlbLJO5xtdOZ6i9UNTdIl2LbicWi38vekxMRN9Ac0zW/ISo0bRMaOh43ZHY7Ju6xtgB8g6+I+avkNmPM+vjLAB0RJuidui9y8tmT+g6F1R4ldbCEMtfvwAeIdex0KFbg/vo86wPVR+8iNivNy8/i53JzSoheLiybPRAaGrAF0FhmdJvnKtyHbDTNJYNiFpdTyig8HO/IuYDtXcE+OXsHKivhJefcxruL6SglfPn0KL3OCEOACkiBI7dzc66vF/LTiqVVdbb2XnjvYv3W4vevdoRWnV+3edpWbMupEUSUFpDIKTrf3/Hh0V+nXl0dSA3saqchApHyNMbvw5NH0a9/3te9d89W8tW/sP5zuHLyyfsbxV35b/fMLL2WmX+3Hn6X3rH2+ZvaOGfs+4c+fOvPynC/3J5kvhleNDDZufppqeDtyXPp2SZpvG9y05XDbX4n5A99U76WXeLyTf2cWbzkx9PesqGXWL7t84eSbjw23VuzqLt/xw8hAxfuJ2J+Rc1Udrx6ruLziVIV58ey0BUeOny/bPpKeuvLCrDknNr13aZ0y+YPPyzvQhkPD1K/Usz+t3zZw8OxH27cdmFmd3MC2rfuUvbjqTP2hhqG3zl250vfOpNebn9i8t6Z/6x/Hmp9Z+l3PkLxuj1CY6K85stsafvzjbPr+Abs3nTUaDwAA"
    }
    
    private var endPoint: String {
        let baseUrl = "https://api.ebay.com/buy/browse/v1/item_summary/search?",
            query = "q=\(keyWord ?? "")&",
            groupBy = "category_ids=\(filterBy?.rawValue ?? "")&",
            limit = "limit=50&",
            buyOption = "buyingOptions%3A%7BFIXED_PRICE%7D",
            condition = "conditions%3A%7BNEW%7D&",
            filter = "filter=\(buyOption),\(condition)",
            sort = sortBy?.rawValue ?? ""
        return baseUrl + query + groupBy + limit + filter + sort
    }
    
    private var urlSession: URLSession {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        return URLSession(configuration: config)
    }
    
    func retrieveDataByName(offset: Int, _ completion: @escaping ([Root]?) ->()) {
        guard let url = URL(string: endPoint+"&offset=\(offset)") else { return }
        
        print("URL: \(url)")
        
        var merchendise:[Root]? = [Root]()
        requestData(forUrl: url, with: urlSession) { (_response, _merchendise) in
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
