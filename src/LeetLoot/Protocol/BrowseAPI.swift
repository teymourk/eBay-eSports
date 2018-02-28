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
        return "v^1.1#i^1#r^0#f^0#I^3#p^1#t^H4sIAAAAAAAAAOVXa2wUVRTuttsqlodBgfJIWIZHojizd2a6O7MTduPS0rRSaGHXCiWm3J29w067O7POvdt2TTRroUQSYgzKK0TtD/0BgmiIQHwjGNRU4g8JxtcvoiUxKREjpBDxznRbtpXwLELi/tnMueeee77vfOc+QK5s3KMbazeen+C6r7gnB3LFLhdfDsaVlS6cWFI8o7QIFDi4enLzcu6ukr5FGKaSaWUlwmnTwMjTmUoaWHGMQSZjGYoJsY4VA6YQVoiqRMLL6hWBA0raMompmknGU1cdZATNz/M+SQSSHPfF+Bi1GkMxo2aQkZFfklWfhgQQ03x+kY5jnEF1BibQIHQ+4GUWCKwgR4GkiJLCBzgx4G9mPE3IwrppUBcOMCEnXcWZaxXkeu1UIcbIIjQIE6oL10QawnXVS5ZHF3kLYoXyPEQIJBk88qvKjCNPE0xm0LWXwY63EsmoKsKY8YYGVxgZVAkPJXML6TtUIz4g+4CoIlHjAfTBMaGyxrRSkFw7D9uix1nNcVWQQXSSvR6jlI1YK1JJ/ms5DVFX7bH/VmRgUtd0ZAWZJYvDq8ONjUxoqQ4tiBNRth4hUm+ahG1cWc1KvFiJZE0S2Ligin455s8vNBgtT/OolapMI67bpGHPcpMsRjRrNJoboYAb6tRgNFhhjdgZFfoFhjiUqZ93qIoZkjDsuqIUJcLjfF6/AsOzCbH0WIag4QijBxyKggxMp/U4M3rQ0WJePp04yCQISSteb0dHB9chcqa1zisAwHtXLauPqAmUogrpTNm9PuivX38CqztQVERnYl0h2TTNpZNqlSZgrGNCgt8nir487yPTCo22/stQgNk7siPGqkMCqgh4WBmjolERL8pj0SGhvEi9dh4oBrNsClptiKSTUEWsSnWWSSFLjyuiTxNEWUNs3B/Q2MqAprExX9zP8hpCAKFYTA3I/6dGuVGpR1QzjRrNpK5mx0TwYyZ20Yo3QotkIyiZpIYbVf1VQWIb5B2HZ/f6TUG0Y2AaBKZ1ztY2p5oprwnppmabWpysbwu3Ts/De6qoFOAgUj0+eJBxDlwOt6uchbCZsegZzjXY+3rUbEMG7RJimckkspr422Ji7Hb0u7SbXxWVmtQpjS33GrKb3CZvUduQ3EXU7i7Xmqsg5330lgjESjFwW9iqnLpGs//BpnVTha01MUHxO3AB8Y58DoWKnB/f5XofdLneoy8q4AXz+blgTlnJk+6S8TOwThCnQ43D+jqD3vItxLWhbBrqVnGZa82sd3e3FDzAep4GFcNPsHElfHnBewzMujJSyk+aNoGXgSDIQBIlPtAM5l4ZdfNT3Q/nTp1csvPomu+azu15eduvP6DJUuNLYMKwk8tVWkSVUTRz++lo68qZ1e769tS5n54PnP7lg7ZdUX1rn6vvsYkH3z52pH9V3+zWHVVNivn5tM2JydvEE8ePt6zd+tvJ8m9O9Zaf/WLBx380TVlNehOHo7uUZ3dcHHi899uP3gyu2H/pQLcp7V361wP8mQulX/9odLRt2rRn6sCLta0P7Zy+YGBbz+zs+oNHL3+ytjfWvf7Ymeb9r4D2N5RnBmYeev3nfVNqp7griqTf95/t6v80UVlRk3vqTOXeI/M2PLL98lsnlFR/+/c90muQm1SGP/xs/IE/Dx2G3Xz/+vsbIvpXF09u6Zr+XF3xhgd3F/09e/7E883dC9/ZN3nW+SdmzNk+74JWgtsuhSs2u7984VXTP1i+fwDmCJl9Gg8AAA=="
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
