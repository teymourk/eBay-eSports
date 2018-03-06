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
        return "v^1.1#i^1#p^1#r^0#I^3#f^0#t^H4sIAAAAAAAAAOVXX2wURRjvtdeWBlo0QUCCyXXBaDC7O7t7u3e3cpccLYSzpS29igJB2Nub7Y292z135mhPTGj6gIIm+CdoopEAL9jQhyoohBjrQ23AEFBfQLFGFBpiUOTJEIJxdnst10r4W4TEe7nMN9988/1+3++b2QHdFVWLtizf8le1p7J0VzfoLvV4hOmgqqL8qZqy0nnlJaDIwbOre2G3t6fs/GKsZdJZtRXirGVi6OvKpE2susYwk7NN1dIwwqqpZSBWia7GoysaVZEData2iKVbacYXqw8zkqYHhYQgBaUAkCQ5Qa3mWMw2K8wkNCBCmNTlRAJAQdboPMY5GDMx0UwSZkQgBFkgsUBpE4EqCKogc7IfrGF8q6CNkWVSFw4wETdd1V1rF+V641Q1jKFNaBAmEosuizdHY/VLm9oW80WxIgUe4kQjOTxxVGcloW+Vls7BG2+DXW81ntN1iDHDR0Z3mBhUjY4lcwfpu1TLiiFLIUkJ+aESChlwSqhcZtkZjdw4D8eCkqzhuqrQJIjkb8YoZSPxItRJYdREQ8Tqfc7fypyWRgaCdphZuiS6OtrSwkQakGZrONXGNkJIGi2LsC2t9WxAkPwwaARENinqkhJMKIWNRqMVaJ60U51lJpFDGvY1WWQJpFnDydyAIm6oU7PZbEcN4mRU7CeOcShRP36sijmSMp26wgwlwucOb16B8dWE2CiRI3A8wuQJl6Iwo2WzKMlMnnS1WJBPFw4zKUKyKs93dnZynRJn2e28CIDAP7+iMa6nYIY2W1fG6fVRf3TzBSxyoehUW9RfJfkszaWLapUmYLYzEVGRaZMXeJ+YVmSy9V+GIsz8xI6Yqg6hfSGHQooWCCmCGBDlqeiQSEGkvJMHTGh5NqPZHZBk05oOWZ3qLJeBNkqqkmyIUtCAbFIJGaw/ZBhsQk4qrGBACCBMJPRQ8P/UKLcq9bhuZWGLlUZ6fkoEP2Vil+xki2aTfBym09Rwq6q/LkjsgLzn8Jxevy2ITgxMg2hZxDna5nQrw1saPdQc03o367vCjeh9+EAVlQIcRYqSoxcZ58Ll8EadsyG2cja9w7lm51xvszqgSbuE2FY6De1Vwl0xMXUn+n06za+LSk8jSuP6Bw3ZbR6Td6htjdxH1N4ez9rrIBdkEUhKAATurq51bl3b8v/BoXVbhV1uYQKT9+ADhJ/4HIqUuD+hx/Mp6PF8TF9UgAePCwtAbUXZs96yGfMwIpBDmsFh1G7Sr3wbch0wn9WQXVrhWTu/v3d90QNs1zowd/wJVlUmTC96j4H512bKhZlzqoUgkIBC71dBkNeABddmvcJs76zK4ZHeWXBa/dlDLU/UPuP9ZM+Gma+C6nEnj6e8hCqj5OBrHWcuvCn1pvbIJbPfeP1gx7fo3C9n1Ka5F0l/H7e15rmTg0Nf7v9s5pO62YhOnP9xcOuCru1H+y4tOvznC5d39i3aVL/Dqtm+t1f2H9v2+7Kr1QcOTnu7vcKPNp+uHXqE2Xfg1KFzC7+68vCFD4/2vzzSwNd84et/qLpqLzN0qvnpb4Y2xY6ciPkf5WZcAWzdD8LiyqMN+1tL/7g82FqZOtx8ceTnv8Mjqd186+bq4+E646fH5pw/WX62c3Zt+5nQ6u83Xdq4d8Nua3XwrXXvf9QTyp1+J3uYazo2/+ud7LaBD8IDA/u2DR6L/vbSVbFv7nfDKxre/fzE8f3e4feGf42s1FfOU6YduTrwymj5/gGGyM5VGg8AAA=="
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
