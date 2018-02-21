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
        return "v^1.1#i^1#f^0#p^1#I^3#r^0#t^H4sIAAAAAAAAAOVXa2wUVRTu9rGkqQVJGlAgYZkiGGBm7+x09jGhmyx9QKV0W3apQiXlzsyddujuzGbuXcqqjbUoBh+JQf0BhGTRkGhMpJiof8SoIGhUYiSS4AuQSCSUNEpEDZB4Z3Yp20p4FiFx/2zm3HPP/b7vPGYu6HeXz9u4ZOOfla4Jxdl+0F/scvEVoNxdNn9iSfG0siJQ4ODK9s/uLx0o+XUhhslESlqOcMo0MPKsTyYMLDnGWiZtGZIJsY4lAyYRlogixSLLmiUfB6SUZRJTMROMp6m+lgkoAd4noKAgKwKQRZFajUsx42Yt40MiVAOqEBAUQfYLKl3HOI2aDEygQeg64IMs8LE+Pg5EqcYviSHOVwNWMZ52ZGHdNKgLB5iwA1dy9loFWK8OFWKMLEKDMOGmSGMsGmmqb2iJL/QWxArndYgRSNJ49FOdqSJPO0yk0dWPwY63FEsrCsKY8YZzJ4wOKkUugbkJ+I7UYkgLwGBAFgSFBwLUxkXKRtNKQnJ1HLZFV1nNcZWQQXSSuZaiVA15LVJI/qmFhmiq99h/bWmY0DUdWbVMw6LIykhrKxNeqkML4u4424wQaTZNwrYur2cDvFCDglrAx6o+RfAHZX/+oFy0vMxjTqozDVW3RcOeFpMsQhQ1GquNUKANdYoaUSuiERtRoV/gkoYCv8pOai6LadJt2HlFSSqEx3m8dgZGdhNi6XKaoJEIYxcciWoZmErpKjN20anFfPmsx7VMNyEpyevt7e3legXOtLq8PgB47yPLmmNKN0pChvravZ7z16+9gdUdKgqiO7EukUyKYllPa5UCMLqYsM8vCoKY1300rPBY678MBZy9oztivDpEEWXglwWRFxWoKqHAeHRIOF+kXhsHkmGGTUKrB5FUAiqIVWidpZPI0lVJEDWfENQQq/pDGlsT0jRWFlU/y2sIAYRkWQkF/0+Ncr2lHlPMFGo1E7qSGZeCH7diFyy1FVokE0OJBDVcb9VfkSS2Sd52enav3xBFOwamQWBK5+za5hQz6TUhHWq2qdNBfUu8dfo+vKuSSgnmmOpq7kXGOXQ5vE7hLITNtEXf4VzUnutxswcZtEuIZSYSyGrnb0mJ8Zvod2iaX5GVktCpjJ13G7MbHJM3WduQ3EHWpQOujisw50U+xIfodA7dErc6J6/xzH8wtG4osUtMTJB6Gz5AvKOvQ+Ei58cPuN4FA67d9EYFvOABvhrMcpesKC25ZxrWCeJ0qHFY7zLoV76FuB6USUHdKna7OmYMvtlZcAHLrgb3jVzBykv4ioL7GJhxeaWMnzS1kg8Cn48HYo1fDK0C1ZdXS/kppVW/r5v+/O72B08Yx83K9m1r2nbBlcdA5YiTy1VWRCujaLmslvN/zznzQdHsukH3mueklsaj2Lw4vBd/vPPeg39Ya889WrVlwdtfnfzrUNuFCx3RSSfdv0x54fCcqubf+l5k/Tu+3XDmwoSKp5+YqHXHq7tWn90eubhpMX6y8f3zk08dPnt6F5r7ekXFvs2PfTTtQHT/0tPa3persjOX7n0NHBv+tPrzl4yJw4PHfzhy6Pstpa8+Uz/3i4aWlUe+PNW37pUFbzzet3/fjupv5n94cJvc/J47tSV7wBweatvWI+34+aGNT339U3aD2Jdh98z/rv6TwWdPHy3Zunje1K3ed4ZaT8hv+at2Rjd1XlzSAJomnxtqm97b2bHncHbWZ8fOb546e+b9+tDmFQcXPOz9cXsuff8AXRSTYhoPAAA="
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
