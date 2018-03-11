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
    
//    private var token: String {
//        return ""
//    }
//
//    private var urlSession: URLSession {
//        let authString = "Bearer \(token)"
//        let config = URLSessionConfiguration.default
//            config.httpAdditionalHeaders = ["Authorization" : authString]
//        return URLSession(configuration: config)
//    }

    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ()) {
        
        //QUICK FIX FOR NOW
        Token().getToken {
            let authString = "Bearer \($0)"
            let config = URLSessionConfiguration.default
                config.httpAdditionalHeaders = ["Authorization" : authString]
            let urlsession = URLSession(configuration: config)
            
            DispatchQueue.global(qos: .userInteractive).async {
                let task = urlsession.dataTask(with: url) {
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
