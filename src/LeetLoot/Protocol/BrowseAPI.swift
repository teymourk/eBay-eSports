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
    private var token: String {
        return "v^1.1#i^1#I^3#p^1#f^0#r^0#t^H4sIAAAAAAAAAOVXbWwURRjutb1ChYJpFAhWc24picDuztz2vlZ6crQUKqUtvbNKEcnc7my7crd77MxxvURjKQEEUgIYg0KgKCai8gOEasIPIgo/iMQgP9QoGokR0Ih/iR9EZ7dHuRbCZxESL9lc9p133nmf533emR3QXVI6bc28NRfLXKMKd3WD7kKXC44BpSXu6eOKCie7C0Ceg2tX95Tu4p6i8zMJSiZScismKdMg2NOVTBhEdow1XNoyZBMRncgGSmIiU0WORhY0yl4ByCnLpKZiJjhPQ10N5wUajgc1L4wHYBCrkFmNyzFjZg0XwpIah8gb8vlAyB9iw4SkcYNBKDKoPR0GeSDxAMaAJAMo+6AAvIF2ztOGLaKbBnMRABd2spWduVZeqtfPFBGCLcqCcOGGSH20OdJQN6cpNlPMixXO0RCliKbJ0LdaU8WeNpRI4+svQxxvOZpWFEwIJ4YHVhgaVI5cTuY20neYDmkKZlSjAAgo1Yo6MlTWm1YS0evnYVt0ldccVxkbVKfZGzHK2Ii/iBWae2tiIRrqPPbfwjRK6JqOrRpuzuzIokhLCxeeryMLkc4Y34gxbTRNyre01vEBKFXjoBbw8qpXkfzBuD+30EC0HM3DVqo1DVW3SSOeJpPOxixrPJQbLyPmCjfMqdlotiIatTPK9/Nd5hB62+2iDlQxTTsNu644yYjwOK83rsDgbEotPZ6meDDC8AGHohoOpVK6yg0fdLSYk08XqeE6KU3JopjJZISMJJhWh+gFAIrPLWiMKp04iTjb1+51x1+/8QRed6AomM0kukyzKZZLF9MqS8Do4MJev0+SfDneh6YVHm69ypCHWRzaESPVIdUhNaBISEJxSWPdAkaiQ8I5kYp2HjiOsnwSWcswTSWQgnmF6SydxJauypJP80pBDfOqP6Tx1SFN4+M+1c9DDWPAGjeuhIL/p0a5WalHFTOFW8yErmRHRvAjJXbJUluQRbNRnEgww82q/pogiQ3y7sOze/1WINoxCAuCUrpga1tQzKRoIrap2aalTtZ3hFtn5+F9VVQGcACprg4cZIIDVyArFMHCxExb7AwXmu19PWYuwwbrEmqZiQS22uAdMTGCO/q92c2viUpJ6IzGpfcbslvcJm9T24jeS9TFPa72q5FDHwwFA5IE70yttU5dY9n/YtO6lcLOMwnF6l34ABGH3obCBc4P9rj6QY9rP7tQARFUwUrweEnRM8VFYycTnWJBR5pA9A6DfeVbWFiGsymkW4UlrsUV+95bmnf/2rUETBq8gZUWwTF51zFQcWXEDcdPLINBIAFoPz7YDiqvjBbDCcUPhdaKf+9euWg7tyTc++qUqVXBjQ9OAGWDTi6Xu4AJo8Do23YitWCaG4+eG/+nd/O6Get6frIuhX/1bxCPJT/68pD/+9azqe6x6z98bc8kyb1v/puVsP/AE0d++/m7An3iK6vE1Su2ZxrB5/PFGYdn1ZXXj+1/9q3aTd+s7mu7+MCmeVzTwkdHCaerZn/6sHB4vLJlx+9nzmzd2Xt88Z5Vx0ddqDw9dd1Xm984N65+8fNftE4s9fJV7xzo+uxY786332/Z1n7pcFnH+g1F5RXll85xB+t+dDcGChuObJ119NSJk3zhQf+36RfOvpRZDvtWnjwy7cmKpz4Gp37Y/snoE4cyF+u0vvWRHerLj/S//u758qOPVe394K+50y/8Eti/9+k/xvy5/8CFePnyLWjt17tjA+X7F59sgS4ZDwAA"
    }
    
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
