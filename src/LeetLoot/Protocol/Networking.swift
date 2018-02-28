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
    func requestData(forUrl url: URL, with session: URLSession, completion: @escaping (RequestRespnse, Model?) -> ())
    func decode(data: Data) -> Model?
}

extension Networking where Self == Model {
    func requestData(forUrl url: URL, with session: URLSession, completion: @escaping (RequestRespnse, Model?) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let task = session.dataTask(with: url) {
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
