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
        return "v^1.1#i^1#p^1#r^0#I^3#f^0#t^H4sIAAAAAAAAAOVXbWwURRju9dqaCi2WD9GKci7yB9i92d372Ft7F4+WSqW0hTsqlpC6tztLl97tnjtztocBjxqJIqIkJahRLComJJWPBFTUEEVRCYkIf4j8QU1DEEGiAUWC4uzeUa6V8FmExPtzmXfeeed9nvd5Z3ZApqR00rLpy/4oc9xW2JMBmUKHgx0GSkuKJ5c7CyuLC0Ceg6Mn80CmqMt5pApJiXhSnA1R0tARdHUm4joSbWOQSpm6aEhIQ6IuJSASsSxGwjPrRY4BYtI0sCEbccpVVxOkvIIHsAoUfAEBAtUfIFb9fMyoEaRYhVUlxaMCmff4A4JM5hFKwTodYUnHQYoDrEADjub8UcCLgBM9PMMJgRbK1QxNpBk6cWEAFbLTFe21Zl6ul05VQgiamAShQnXh2khjuK5mWkO0yp0XK5TjIYIlnEIDR9WGAl3NUjwFL70Nsr3FSEqWIUKUO5TdYWBQMXw+mWtI36aaVQKqIBGOeZn3xqA0JFTWGmZCwpfOw7JoCq3ariLUsYbTl2OUsBFbCGWcGzWQEHU1LutvVkqKa6oGzSA1bWr4sXBTExWaoUmmhNqidD2EuN4wMN00u4b2s7wHCqqfoxVO5n1CzJfbKBstR/OgnaoNXdEs0pCrwcBTIckaDuSGE7153BCnRr3RDKvYyijfz9vPId9iFTVbxRRu0626wgQhwmUPL1+B/tUYm1oshWF/hMETNkVBSkomNYUaPGlrMSefThSk2jBOim53R0cH08EzhrnAzQHAuufOrI/IbTBBFNKZsHo9669dfgGt2VBkSFYiTcTpJMmlk2iVJKAvoEKcz8vz3hzvA9MKDbb+y5CH2T2wI4aqQ1QO+Dgo8B5JkFje7x2KDgnlROq28oAxKU0nJLMd4mRckiEtE52lEtDUFJH3qhwvqJBWfAGV9gRUlY55FR/NqhACCGMxOSD8nxrlSqUekY0kbDLimpweEsEPmdh5U2mSTJyOwHicGK5U9RcFiSyQNxye1etXBdGKgUgQKakxlrYZ2Ui4DYkcapap1c76unBr5D68pYpKAGaRakr2ImNsuAx6UmZMiIyUSe5wptE616NGO9RJl2DTiMeh2cxeFxNDd6LfpNP8oqjkuEZobL3VkF3lMXmN2pbwTURd1OWYdxHkrJcN+AHw+vjrwlZt1zWa/g8Orasq7HQDYajcgA8Q98DnUKjA/rFdjm2gy7GFvKiAG0xkJ4D7S5xzipzDK5GGIaNJKoO0BTr5yjch0w7TSUkzC0sc88Zt3tCa9wDrmQ/u6n+ClTrZYXnvMTDuwkwxO2JsGSsAjvMDHnAevgVMuDBbxN5ZNLqUfxntTvf2OXekZ993ev7G8auHnwZl/U4OR3EBUUZB98nNO0+M++VMUcue9RXrJnVXnqr9eetHVeFTv36y6825XYuOnJ3B9z2yf/L25b9v2TQ+XHLoWf30zrX7l47JvFQ+pzX91KhFE39jPrh976Zzjy/MKIuP7+7tdX767Wd7lz2zomrXrGGPHm7eNSuE15ydEv3p7JJzjoOdU7btW3Rszzbj+7dw++qj8vNfr3/juRGvV4/sRqdW3v0ePfb4j4deODZmzomRo40nPhzT3HdwY7fwzsol69+/l9s+6rD20JrjX3a3rYt2fFH9YuX8wCq1or2ib8fWRt/iDSteK3+67MwPtZ8f2Nf3Z/nHtSunfLWK/e6eyWDi0Vde/XvayQfb3y356+2lJ3u/edi7ac/aO3yOzooD2fL9A8IOEJEaDwAA"
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
    
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: imageURL) {
                (data, response, error) in
                guard error == nil else { return }
                
                if let imgData = data, let cachedImage = UIImage(data: imgData) {
                    DispatchQueue.main.async {
                        self.imageCache.setObject(cachedImage, forKey: urlString)
                        self.image = cachedImage
                    }
                }
            }.resume()
        }
    }
}
