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
        return "v^1.1#i^1#r^0#I^3#f^0#p^1#t^H4sIAAAAAAAAAOVXW2wUVRjudntxwUqC15Bql6HEUJ2ZM7O32QldbLtcCqXbsgtWUMpczrRDZ2fWOWdpVyVuaoQEhGBEExIJFQyRqIESEG3wAfQFo4SISjQKD75IxAeMwUSN8czsUraVcC1C4r5s5j//+c/3ff9l5oB8la9h3YJ1v9d4qsuH8iBf7vFwk4GvqvKxe7zl0yrLQImDZyhfn68Y9P40G0lpIyMugShjmQj6B9KGiUTX2EhlbVO0JKQj0ZTSEIlYEZNNi9tEngFixrawpVgG5W+NN1KaxoUFGNVACAahDKLEal6MmbLIepjjIrIclXgZRuRwgKwjlIWtJsKSiRspHnACDQI0CKY4QQwCkeeZMAgup/zLoI10yyQuDKBiLlzR3WuXYL0yVAkhaGMShIq1Ns1LJppa43PbU7PZklixog5JLOEsGvvUYqnQv0wysvDKxyDXW0xmFQUiRLGxwgljg4pNF8HcAHxXaoEPQkHRAoIiqFEJhCZEynmWnZbwlXE4Fl2lNddVhCbWce5qihI15NVQwcWndhKiNe53/jqzkqFrOrQbqbnNTU81dXRQsUW6ZEuoN0W3QYjbLAvTHUvidIQLEMZahKdVXgmEBTlcPKgQrSjzuJNaLFPVHdGQv93CzZCghuO1CZRoQ5wSZsJu0rCDqMSPB0UNQ1F+uZPUQhazuNd08grTRAi/+3j1DIzuxtjW5SyGoxHGL7gSNVJSJqOr1PhFtxaL5TOAGqlejDMiy/b39zP9Acaye1geAI7tWtyWVHphWqKIr9PrBX/96hto3aWiQLIT6SLOZQiWAVKrBIDZQ8X4cCgQCBV1HwsrNt76L0MJZ3ZsR0xUh4RUMooiIUGSZQFE1MhEdEisWKSsgwPKUo5OS3YfxBlDUiCtkDrLpqGtq2IgpPEBQYO0Go5qdDCqabQcUsM0p0EIIJRlJSr8nxrlWks9qVgZ2GEZupKbkIKfsGIP2GqHZONcEhoGMVxr1V+WJHJI3nJ6Tq9fF0UnBiJBpIzOOLXNKFaatSQy1BxTt4v6pnjr5H14RyWVECww1dXCi4xx6TJojcLYEFlZm7zDmYQz11NWHzRJl2DbMgxoL+NuSomJm+i3aZpflpVi6ETG7juN2XWOyRusbQnfRtYVg54Vl2HOhZzJLAg8f1PcWty8pnL/wdC6rsQusBCG6i34AGHHXodiZe6PG/QcBIOeYXKjAiyYyc0A06u8Syu8d09DOoaMLmkM0ntM8pVvQ6YP5jKSbpdXeVbU7tvTXXIBG3oGPDR6BfN5uckl9zFQe2mlkpvyYA0ngAAIckIQ8PxyMOPSagX3QMV9w617q1cerv3lV9/ZSUfrwotOnRh5D9SMOnk8lWWkMspeQnVvDvewU5PbjM3erT+kV24c2rLprh33dP+44eSnPdXtj3Zt3z91j669suq8b17X5upjdZvWLvztwvzO1Sc/PHp8qd19+viXu/fOSY14t24//0likrzNfOfvr/YvvPecMmtHD1uzayDM1vvW9x2gcvvO7e3asmbn3COLXv/izOGk/4WRI2K2RXn2kQtrv5NrZx+adr9v1/qGREvLW8eNd1+c8/FzF2bRM+tPfD6F1hNn8o8/Ya7Z+erBVXV/5L/tir/tP7+74dDmo53m5I3znzx17sDwsaD5V/zP+Proz+E9dZ3N0+fH69947ZvTX79vVVXgl2tTg8Jn338wUnV2w9n0R+nnG8Rm6+G8+HRDIX3/AIOApDMaDwAA"
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
