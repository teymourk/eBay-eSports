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
        return "v^1.1#i^1#p^1#I^3#r^0#f^0#t^H4sIAAAAAAAAAOVXbWwURRjuXT/gAmg0yEeFcC6Cprp7s7v3tSs9PXoHNJS2cEfFAp6zu7Pt2r3dy86c7SX9URolqAEVYmJIxIaIKRETJCCEBH+YkPBDQH6QiIARAoagGIIhEj+Cu3tHuVbCZ1ES789l3nnnned53ved2QF9Nb661QtW/zbBM8Y70Af6vB4POw74aqqfeajSW1tdAcocPAN9T/ZV9Veem4NhVs+JSxDOmQZG/p6sbmDRNdZTecsQTYg1LBowi7BIZDEVX9QkcgwQc5ZJTNnUKX9jop5SI6rKyyoQ+GiQ5yXOthrXYqbNegoq0bAqqUgSBI6DYWDPY5xHjQYm0CD1FAfYKA14GgTTHC9yghiKMGFeaKf8bcjCmmnYLgygYi5c0V1rlWG9OVSIMbKIHYSKNcbnpVrijYlkc3pOoCxWrKRDikCSx8NHDaaC/G1Qz6Obb4NdbzGVl2WEMRWIFXcYHlSMXwNzF/BdqSNsFAVlTlYkFQYFOTgqUs4zrSwkN8fhWDSFVl1XERlEI4VbKWqrIb2KZFIaNdshGhN+529xHuqaqiGrnkrOjb8Ub22lYgs1aEHcmaabECJNpkno1iUJOsLyQRRVIxytcDIfjkrh0kbFaCWZR+zUYBqK5oiG/c0mmYts1GikNmyZNrZTi9FixVXiIBryC6UBO6Qh2+4ktZjFPOk0nLyirC2E3x3eOgNDqwmxNClP0FCEkROuRHbb5HKaQo2cdGuxVD49uJ7qJCQnBgLd3d1MN8+YVkeAA4ANLFvUlJI7URZStq/T60V/7dYLaM2lIiN7JdZEUsjZWHrsWrUBGB1UjAuHeD5U0n04rNhI6z8MZZwDwztitDpEiLISlARJCIXZIILsaHRIrFSkAQcHkmCBzkKrC5GcDmVEy3ad5bPI0hSRD6kcH1URrYQFlQ4KqkpLISVMsypCACFJkoXo/6lRbrfUU7KZQ62mrsmFUSn4USt23lJaoUUKKaTrtuF2q/6GJLFD8r7Tc3r9jig6MbAdBOY0xqltRjazARPah5pjyrio74m3Zt+HD1RSbYJFpppSvMgYly6DX5MZC2Ezb9l3ONPinOtpswsZdpcQy9R1ZLWx96TE6J3o/9FpfkNWsq7ZMmYeNGZ3eEzeZW1D8h+yrur3LL8BczbEAQ6EWSFyT9wa3LymC//CoXVHiV1gYoKU+/ABEhj+HIpVuD+237ML9Hs+t19UIABmsTPBEzWVS6sqx9dijSBGgyqDtQ7D/sq3ENOFCjmoWd4az/Jp27dmyh5gAyvBlKEnmK+SHVf2HgPTrs9Usw9PnsBGAQ+CHM8JoUg7mHl9toqdVDVx3Ue+FVse3bfJC6fFJwWvPrv+RO9FMGHIyeOprrAro2LtK49tn+rZmal97h364k79Qu1XJ311cu/azXXjL5JMDAnNh5fOOP/Wy3/N7PJ3v7mh7lRv4runrkymviZRrI3buH/9nvODl88ld35x6RB7/JGJOy4kOj7pONa8eOD9qunr3/0le3bdez/86R3ctXbr3l8bWy6fe/uDP/R1DbOXzT8PDz6/p+fs7qPp9kPbajLbt2Qz3k1w82czrh7dm461xX/8/tT+mo0nD28bnLpyxYmKM0e27P4wueHM7/tnLR4rTTn9xoHE6U8PZHzLxkyPRJWfW87OWLPp2yMr82vGHtzRe8k3eGVVwTz508HDG9r2JWcnk98cv8Q19Wx9+uNV88duZB9f6H3de+KFF788cKyYvr8BfFq8HhoPAAA="
    }
    
    private var urlSession: URLSession {
        let authString = "Bearer \(token)"
        let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Authorization" : authString]
        return URLSession(configuration: config)
    }
    
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async { [urlSession = self.urlSession] in
            let task = urlSession.dataTask(with: url) {
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
    
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            URLSession.shared.dataTask(with: imageURL) {
                (data, response, error) in
                guard error == nil else { return }
                
                if let imgData = data, let cachedImage = UIImage(data: imgData) {
                    DispatchQueue.main.async {
                        self?.imageCache.setObject(cachedImage, forKey: urlString)
                        
                        if url == self?.imageURLStringCheck {
                            self?.image = cachedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
