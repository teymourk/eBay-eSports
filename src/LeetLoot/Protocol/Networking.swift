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
    associatedtype Model:Decodable
    func requestData(forUrl url: URL, completion: @escaping (RequestRespnse, Model?) -> ())
    func decode(data: Data) -> Model?
}

extension Networking {
    private var token: String {
        return "v^1.1#i^1#p^1#f^0#r^0#I^3#t^H4sIAAAAAAAAAOVXa2wUVRTu9hmklRjlIVazTCEGZGbvzO7O7o7smqWFtFBoYbcEyqPenbnTjp2d2cy9a1mjsTaCEDCBmDRRg21MNJKIwgpGYzQoiS8UGpTEEA3+wZCi+AMChpfemd2WbSU8i5A4fyZz7rnnft93zj13LuguHzdrff36s1WuiuL+btBd7HLx48G48rLH7i0pnlpWBAocXP3d07tLe0qOz8EwqaekpQinTAMj99qkbmDJMYaZtGVIJsQalgyYRFgishSLLmqUBA5IKcskpmzqjLuhLswEggkeCgjQlwBDfpFajaGYcTPMKLwv4EeyLIYSohr0++g4xmnUYGACDRJmBMAHWSCwvBAHoiT4JS/PBXihlXEvQxbWTIO6cICJOHAlZ65VgPXqUCHGyCI0CBNpiM6PNUUb6uYtjs/xFMSK5HWIEUjSeORXrakg9zKop9HVl8GOtxRLyzLCmPFEciuMDCpFh8DcBHxH6hCUBSHAA9EvKGIioI6JlPNNKwnJ1XHYFk1hVcdVQgbRSOZailI1Ek8hmeS/FtMQDXVu+7UkDXVN1ZAVZubNja6INjczkYUatCDuiLONCJFG0yRs89I6NsB7fSioBgRWEWSvGEyI+YVy0fIyj1qp1jQUzRYNuxebZC6iqNFobfgCbahTk9FkRVViIyr0Cw5pCHytdlJzWUyTDsPOK0pSIdzO57UzMDybEEtLpAkajjB6wJEozMBUSlOY0YNOLebLZy0OMx2EpCSPp6uri+vycqbV7hEA4D3LFzXG5A6UhAz1tfd6zl+79gRWc6jIiM7EmkQyKYplLa1VCsBoZyKC6Pd6/XndR8KKjLb+y1DA2TNyR4zVDoGy1++TVdknJECIF8ak2UTyReqxcaAEzLBJaHUiktKhjFiZ1lk6iSxNkbx+VfAGVcQqYkhlfSFVZRN+RWR5FSGAUCIhh4L/p41yvaUek80UajZ1Tc6MScGPWbF7LaUZWiQTQ7pODddb9VckiW2St52evddviKIdA9MgMKVxdm1zspn0mJA2NdvU5qC+Jd4aPQ/vqqRSgjmmmpI7yDiHLoefljkLYTNt0TOca7L7etzsRAbdJcQydR1Zy/hbUmLsOvod6uZXZCXrGpWx7W5jdoNt8iZrG5I7yLq0x7XyCsx5Px/08WLAe2vVWuvkNZ75D5rWDSW23sQEKbfhB8Qz8joUKXIevse1B/S4dtEbFfCAGXwNmFZe0lJaUjkVawRxGlQ5rLUb9C/fQlwnyqSgZhWXu1ZW79zeVnAB618NpgxfwcaV8OML7mOg+vJIGT9hchUfBAIvAFHwe/lWUHN5tJSfVPrA7v1/ZtWHohsmdx6+8M1HLFy9s+h5UDXs5HKVFdHKKJqx4OilRdsu6G/9dJK8OfHI4Re/ilZ8lq5/bs2M9ODF6OOnl7T8cWng8L5TMwfXnH7iu+JNEwNbP1lfMWnvI7UHvo8caM8uZYjgfq8tNC3sem1gzdSX90UHzyx/EH97aveP4qwT2449+mT4pf0wW5sNTTu0dx33dvWmeyqNzCHjzOtTftni+3vVr/d1ZI+eZTsern+j71S0a+NeT4U8s298c1NLzQu971b29vUOfLDiZ+5g/HzlyUw1+m2wZfOGhRufnbAD/XXyh/Nfz9738YILe5o+3HLii893lM1et2v7xXdeWRdOtf7e+yoZyBp7vmzJHuve/P5+7fjF1q2XPp10f6L83O5VFdPPPeM7ODMsHMml7x9jjz/3Gg8AAA=="
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
            print("Error Decoding \(error.localizedDescription)")
            return nil
        }
    }
}
