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

extension Networking {
    private var token: String {
        return"v^1.1#i^1#f^0#p^1#r^0#I^3#t^H4sIAAAAAAAAAOVXW2wUVRjutts2hJtBBEIKWQaFcJnZMzM7exnYNUsLsljahV1qWyBkduZMO3Z3ZpxzlnYFkqYJrQkPYBOioggoqLUQUIMXAn0w8CD6ICTyIODlhYuJEYzEhJjomdmlbCvhWoTEfdnMf/7zn+/7/v8/F9BZMWpu99LuP8e6Kkt3d4LOUpeLHQ1GVZTPG1dWOrW8BBQ5uHZ3Pt3p7iq7tBBJmbQproTINHQEPR2ZtI5ExximspYuGhLSkKhLGYhELIuJ6PJakWOAaFoGNmQjTXliNWHKHwhJPjXlExRfKKQGJGLVb8RMGmEKqpziD0KWZYMgEAopZByhLIzpCEs6DlMcYIM04GiWT3KcyAqiwDNBLthMeRqghTRDJy4MoCIOXNGZaxVhvT1UCSFoYRKEisSiSxL10VjN4rrkQm9RrEhBhwSWcBYN/ao2FOhpkNJZePtlkOMtJrKyDBGivJH8CkODitEbYO4DviN1EAYCii/FBQGnSlAYGSmXGFZGwrfHYVs0hVYdVxHqWMO5OylK1Ei9CGVc+KojIWI1HvtvRVZKa6oGrTC1eFG0KRqPU5HnNcmSUGuSroUQ1xoGpuMra+gAy/tgUA1wtMLJvD+Y8hcWykcryDxspWpDVzRbNOSpM/AiSFDD4dqAIm2IU71eb0VVbCMa9PMlARjUkG22k5rPYha36nZeYYYI4XE+75yBwdkYW1oqi+FghOEDjkRhSjJNTaGGDzq1WCifDhSmWjE2Ra+3vb2daecZw2rxcgCw3sbltQm5FWZIM3Zk7F7P+2t3nkBrDhUZkplIE3HOJFg6SK0SAHoLFeH8As8LBd2HwooMt/7LUMTZO7QjRqpDfDzHKT6Bk1kpJQgcOxIdEikUqdfGAVNSjs5IVhvEZlqSIS2TOstmoKUpIi+oHB9UIa34QyrtC6kqnRIUP82qEAIIUyk5FPw/NcrdlnpCNkwYN9KanBuRgh+xYuctJS5ZOJeA6TQx3G3V35Ikskk+dHp2r98TRTsGIkEkU2Ps2mZkI+M1JLKp2aZ1DuoH4q2R8/CxSiohmGeqKfmDjHHoMmi9zFgQGVmLnOFMvb2vJ402qJMuwZaRTkOrgX0gJUZuR39Eu/ktWclpjci47nFjdo/b5H3WtoQfIWt3l2v1LZizAhsU/IAV+AfiVu3kNZn7Dzate0rsUgNhqDyEC4h36HMoUuL82C7XYdDl+oi8qIAXPMPOBDMqyla5y8ZMRRqGjCapDNJadHLLtyDTBnOmpFmlFa7VVYf61hU9wHavBVMGn2CjytjRRe8xUHVzpJwdP3kseShxLLnIsILAN4OZN0fd7CT3xIELO55bvuroyX518/HPGre4rp167S0wdtDJ5SovIZVRsvfq1jH9m7rdR+OzK5PTL72xtWfb+omHfoDyU+jqX2vKTpsTl1Xt/Ny9/fvzvxkn3n1njmvl+ZYLtccm6VdmTaiaMqXjvaa+J5mLa1IfX//6XE/zGUH9pneCa+Ph/Qc3XYErTs0YqN6MrjRNPnzs8oa92/p6fwk0bJGzz549MO7orJd753x1be7Uk0/MPDL+0gJzOt3/3bzXz0VSVzec+aNn39xru5Z98OOEZUt9+1H1gf298z85vuX4wJzqnT8dWPvpEX+PsPHE2y8lT7f19p08tWagKf776aa/S6/PutzYXln388GB2Fnw5YfZ/vmV0xrHvfrKDt8Xey7zszMXfy3ppmsW7NoTe3Pa+9F9Lyz2fJtP3z/soAxeGg8AAA=="
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
