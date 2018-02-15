//
//  Networking.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/11/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

enum RequestRespnse: Error {
    case success(String)
    case error(String)
}

protocol Networking {
    associatedtype Model: Codable
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ())
    func decode(data: Data) -> Model?
}

extension Networking where Self == Model {
    private var token: String {
        return "v^1.1#i^1#r^0#p^1#I^3#f^0#t^H4sIAAAAAAAAAOVXa2wUVRTudtuShldJULGCWQYRCpnZO8/uTtglC6VpoS/ZpfKQNLMzd+jY3Zlh7l3aNSiliUUD8Q9pGiPEJiZaxBBL8BFCEP2BqUGiEhQSEsXgK0ajgYSIYrwzu5RtJTyLkLh/Nvfcc88933e+c+9c0F1WvqC3rvfiZN+E4oFu0F3s87ETQXlZ6cIp/uLK0iJQ4OAb6H6su6TH/+MipKRTtrwSItsyEQx0pVMmkj1jhMo4pmwpyECyqaQhkrEqx2ONDTLHANl2LGypVooK1NdEKIkVkoIU1qCiSEpS5YnVvBIzYUUolWUBp+phyHJhSdVEMo9QBtabCCsmjlAcYEM04GhWTAAgC4Is8kw4FFpLBVqhgwzLJC4MoKJeurK31inI9fqpKghBB5MgVLQ+VhtvjtXXLGtKLAoWxIrmeYhjBWfQ6NFSS4OBViWVgdffBnnecjyjqhAhKhjN7TA6qBy7ksxtpO9RzQmioHIiD6AWlkK8Mi5U1lpOWsHXz8O1GBqte64yNLGBszdilLCRfBqqOD9qIiHqawLu3xMZJWXoBnQi1LIlsTWxlhYqusJQHAW1J+gGCHGDZWG6ZWUNXc3yAgzp1RytcSovhZJSfqNctDzNY3Zaapma4ZKGAk0WXgJJ1nAsN3wBN8Sp2Wx2Yjp2Myr040Y45Ne6Rc1VMYPbTbeuME2ICHjDG1dgZDXGjpHMYDgSYeyER1GEUmzb0Kixk54W8/LpQhGqHWNbDgY7OzuZTp6xnA1BDgA2uLqxIa62wzRRSFfa7fWcv3HjBbThQVEhWYkMGWdtkksX0SpJwNxARTlJ5Hkxz/votKJjrf8yFGAOju6I8eqQalHnBA3qanUyqScFfTw6JJoXadDNAyaVLJ1WnA6I7ZSiQlolOsukoWNoMk8250M6pDUprNNCWNfppKhJNKtDCCBMJtVw6P/UKDcr9bhq2bDFShlqdlwEP25i5x2tRXFwNg5TKWK4WdVfEyRyQd51eG6v3xJENwYiQRTbYFxtM6qVDloKOdRcU5uX9R3hNsh9eF8VlQDMITW03EXGeHAZtEllHIisjEPucKbZPdcTVgc0SZdgx0qloNPK3hET43ei36PT/Jqo1JRBaGy735Dd4jF5m9pW8D1EXdLjW3cN5KzIhiRRFML8HWFb6tU1kf0PDq1bKmydhTDU7sIHSHD0cyha5P3YHt87oMc3RF5UIAjmsnPA7DL/qhL/pEpkYMgYis4gY4NJvvIdyHTArK0YTnGZb93Mt/e0FTzABtaDGSNPsHI/O7HgPQZmXp0pZac+NJkNAY4VARAEkV8L5lydLWEfLJk+0Bd+dvPw9kO7z1xqOvrtxTR/VnoPTB5x8vlKi4gyijZXVKxsO79A+Llq97rLgw3fb39yyskJe991ts38e+FAmb3w4Dm+8tSsN6Nbf0kPHnjr98pXuV/379nXe6ztRPjjxhOhXdykc30/Lf/sgY7FtRf/qJrd3/rKjOGnjtVOkyo28q9t+qD9yLYvyk/FaSM6Fex7WH9koyYtunBy/p/fzfV/LQxVLT80POTb2tU7lJ5WP2XFkY3TimZ8OOjI31w6+/jn/fuH3xhoPPXR6q8+je9IdE719zegF87Mm11e8/5pY+L8T5afL9/Z2zQ4vFuct/7A5rrkwcPrn2mM7jo8/fTLfV3H535Zc+HwrMVV/XuP7ni9l7Mb67Y0rUrYj17+66Xfdq05/qL5w/NbKp6bfiRXvn8AI4sOaBoPAAA="
    }
    
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) {
            (dataObj, respnse, error) in
            guard       error == nil,
                    let data = dataObj else { return completion(.error(error?.localizedDescription ?? ""), nil)  }
            
            completion(.success("Successfully Requested Data"), self.decode(data: data))
        }
        task.resume()
    }
    
    func decode(data: Data) -> Model? {
        do {
            return try JSONDecoder().decode(Model.self, from: data)
        } catch let error {
            print("Error Decoding: \(error.localizedDescription)")
            return nil
        }
    }
}


class customeImage: UIImageView {

    private var imageCache = NSCache<NSString, UIImage>()
        
    func downloadImages(url: String) {
        let urlString = NSString(string: url)
        
        if let cachedImage = imageCache.object(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            self.image = UIImage(named: "eBay")
            return
        }
    
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: imageURL) {
                (data, response, error) in
                guard error == nil else { return }
                
                if let imgData = data {
                    DispatchQueue.main.async {
                        let cachedImage = UIImage(data: imgData)
                        self.imageCache.setObject(cachedImage!, forKey: urlString)
                        self.image = cachedImage
                    }
                }
            }.resume()
        }
    }
}
