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
        return "v^1.1#i^1#r^0#I^3#p^1#f^0#t^H4sIAAAAAAAAAOVXbWwURRjutb1CKR8atQVS8VhKYmp2b3b3vrrQI9eWQqFf9I6qbaCd251t197tXnbmaE8SrYfgR9SYGhFIrBDBSIxRNPjDqImm8ktLMJGYoBhIVIKpSGyKPzRxdu8o10r4LELi/bnMO++88z7P+7wzO2CwqLhyx9odF+Y5ZuXvHQSD+Q4HXwKKi5wPzS/IX+zMAzkOjr2DFYOF6YIzKzGMxxJSG8IJQ8fINRCP6ViyjdVM0tQlA2INSzqMIywRWQqHmholgQNSwjSIIRsxxtVQV82IfgQCvBhVZJ/C8wKiVv1izIhB53mIvIIoez0BNeAXIJ3HOIkadEygTqoZAfABFogsECKCKHlFCfCcz+vrYFztyMSaoVMXDjBBO13JXmvm5HrlVCHGyCQ0CBNsCNWHW0INdaubIyvdObGCWR7CBJIknjqqNRTkaoexJLryNtj2lsJJWUYYM+5gZoepQaXQxWRuIH2baln1QJ+nSgXA71H8MDAjVNYbZhySK+dhWTSFVW1XCelEI6mrMUrZiD6GZJIdNdMQDXUu629DEsY0VUNmNbO6JvRoqLWVCa7XoAlxb4RtRIg0GgZhW9vqWD8velBA9QusIsiiLxD1ZTfKRMvSPG2nWkNXNIs07Go2SA2iWaPp3HhyuKFOLXqLGVKJldGknxgB/CSHQodV1EwVk6RXt+qK4pQIlz28egUmVxNiatEkQZMRpk/YFFUzMJHQFGb6pK3FrHwGcDXTS0hCcrv7+/u5fpEzzB63AADvfqSpMSz3ojhttoG41esZf+3qC1jNhiLTNqb+EkklaC4DVKs0Ab2HCQo+ryh6s7xPTSs43fovQw5m99SOmLEOqeJ9Hujho6qAoOzjZ6JDglmRuq08UBSm2Dg0+xBJxKCMWJnqLBlHpqZIolcVxICKWMVXpbK0T1U26lV8LK8iBBCKRuWqwP+pUa5V6mHZSKBWI6bJqRkR/IyJXTSVVmiSVBjFYtRwraq/LEhsgbzl8Kxevy6IVgxMg8CExlna5mQj7jYgPdQsU5ed9U3h1uh9eEcVlQLMINWUzEXG2XA5vEXmTISNpEnvcK7FOtcjRh/SaZcQ04jFkNnO3xQTM3ei36bT/LKo5JhGaey605Bd5zF5g9qG5DaiLkw7Oi+DnPfSNaLHH7g5tdbadY2k/oND67oKu9bABCm34APEPfU5FMyzf3zacRikHYfoiwq4wXJ+GVhaVLCxsGDuYqwRxGlQ5bDWo9OvfBNxfSiVgJqZX+ToLH//YFfOA2zvJrBw8glWXMCX5LzHQPmlGSe/oGweHwAiEATRKwK+Ayy7NFvIlxbem5Qfn71m1itfdI/vTjur7hO7t4/9DeZNOjkczjyqjLwlI7+sWeRc/fXohEO5Z01HTfrXPYcnjh+ceLJ2w6cFB367f+zI687intE/wwv7E+fnv7lg2bajzzSVn+r07tu6smjP91t/+qFy+NhQfPkh/uExvmvobfnM5rLWn+86dPJF8EHX/jm9+8eVijM9n000ftQ9tPvUksSY68Ibr5XtWvXEl2ePPf35hVndL3UOrar6prShftfWdZseXF5zunSFeHL9tuai53a7JnZsv/vbuWVf7Ww7uu/3tvaROe/8+MJsYeH5pnWSe/x0fUXf8zsfODqwtPtAXqpzxXjnH+kjr5bm9Z7Y893EubknnipZoJ37a3jRW8e3fxiv3HI2Vv7uyCcvfzwy+t7osfmbz5YMS0eerdyYKd8/+t5pexoPAAA="
    }
    
    private var urlSession: URLSession {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        return URLSession(configuration: config)
    }
    
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let task = self.urlSession.dataTask(with: url) {
                (dataObj, respnse, error) in
                guard       error == nil,
                        let data = dataObj else { return completion(.error(error?.localizedDescription ?? ""), nil)  }
                completion(.success("Successfully Requested Data"), self.decode(data: data))
            }
            task.resume()
        }
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
        
        print(urlString)
        
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
