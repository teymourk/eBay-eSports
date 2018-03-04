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
        return "v^1.1#i^1#f^0#r^0#I^3#p^1#t^H4sIAAAAAAAAAOVXbWwURRju9dqSphYTUGmQH8eCAcHdm729zw09OSgNB+312iuNFhBmd+fahb3dZWfO9jRgafiKsRJFJPGThDSVHwIN9QvUKJJoDCQao0SjiAYCjUqMxKgR0dm7o1wr4bMIiffnMu+8887zPO877+yArrLyGRvmb/it0jGmeHsX6Cp2OPgKUF5WOnOss3hiaREocHBs75raVdLtPDULw5Rmik0Im4aOkaszpelYzBqrmbSliwbEKhZ1mEJYJLKYiNTXiR4OiKZlEEM2NMYVralmUEgOSooiAzkEg0DyUKt+PmazQef9kjcQFKAXIq/CeyQ6j3EaRXVMoE6qGQ/ggywQWOBtBj4R8KI3wHmBr5VxtSALq4ZOXTjAhLNwxexaqwDrpaFCjJFFaBAmHI3UJhoi0Zp5seZZ7oJY4bwOCQJJGg8fzTUU5GqBWhpdehuc9RYTaVlGGDPucG6H4UHFyHkw1wA/JzUvAT/vAYLsk4APwFGRstawUpBcGodtURU2mXUVkU5UkrmcolQNaQWSSX4UoyGiNS77rzENNTWpIquamTcn8mAkHmfCC1VoQdzezNYhROoMg7Dxpho2wAteFEwGPKzikQV/UPLnN8pFy8s8Yqe5hq6otmjYFTPIHERRo+HaeEVfgTbUqUFvsCJJYiMq9AvkNRRCoVY7qbkspkm7bucVpagQruzw8hkYWk2IpUppgoYijJzISlTNQNNUFWbkZLYW8+XTiauZdkJM0e3u6OjgOgTOsNrcHgB49wP1dQm5HaVohXSm7LOe81cvv4BVs1RkRFdiVSQZk2LppLVKAehtTNjj9wmCL6/7cFjhkdZ/GQo4u4efiNE6IR7I+/ikXwpIwSBCEj8aJyScL1K3jQNJMMOmoLUSEVODMmJlWmfpFLJURRR8SY8QTCJW8YeSrDeUTLKST/GzfBIhQNFIcij4fzooV1rqCdkwUdzQVDkzKgU/asUuWEocWiSTQJpGDVda9RcliW2SN5yefdaviqIdA9Mg0FQ5u7Y52Ui5DUibmm1alkV9XbxVeh/eUkmlBHNMVSV3kXFZuhx+WOYshI20Re9wrsHu683GSqTTU0IsQ9OQ1cJflxKj19FvUje/KCtZU6mMy241ZlfZJq+xtiG5iaxLuh2LL8Kc99HOLIQCIHBd3OZm89qc+Q+a1lUldr6BCVJuwAeIe/hzKFyU/fHdjtdAt6OfvqiAG9zDTwGTy5yLSpy3TcQqQZwKkxxW23T6lW8hbiXKmFC1issciyft2bms4AG2fSmoGnqClTv5ioL3GJh0YaaUv31CJR8EAqBXLuC9gVYw5cJsCX9XyR2PxD95c+yROR8sOnO8+Nzgs8szygvbQOWQk8NRWkQro+ju9w6yk6f/uGRf/+YjO8omuHf1v9hXMd69aXHvggWHTXxi4GPuwOurvzqx+6P5M1/5eur7roM/HGVWn1zTtL/+1769/b+Uf7b8UEQLPdZ4gP/z0S/ZnxPH1x3bMjC4W31q3/0rxuOeVeVC6I2/BozN8Ni2l6ate2bGoYp3Nzp3PF7bu3Watb/y+aKq09+WRuubfi8KTz/cOnv1lIFXB88493LjGqNL6oTAxso7H6qfOjhuYey5rVt6Pl+/9uy5RQ2xtUvPgb8ba2ZvMt/aNVuq6pm0ZGfv6TEfuuZtemft0wvaq47uPiV9o3//Xd8Xa04WPxns/WObvge83PLTqnuluLAi1hZ7onb92/f1fNp39mguff8ARZExcRoPAAA="
    }
    
    private var urlSession: URLSession {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        return URLSession(configuration: config)
    }
    
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let task = self.urlSession.dataTask(with: url) {
                (dataObj, respnse, error) in
                guard       error == nil,
                        let data = dataObj else { return completion(.error(error?.localizedDescription ?? ""), nil)  }
                DispatchQueue.main.async {
                    completion(.success("Successfully Requested Data"), self.decode(data: data))
                }
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
    
    var imageURLStringCheck: String?

    private var imageCache = NSCache<NSString, UIImage>()
    func downloadImages(url: String) {
        self.image = nil
        self.imageURLStringCheck = url
        
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
                        
                        if url == self.imageURLStringCheck {
                            self.image = cachedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
