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
        return "v^1.1#i^1#r^0#p^1#f^0#I^3#t^H4sIAAAAAAAAAOVXW2wUVRjudrclBYoxUKwNJMtQjEFn9sxlZ3cn7Oq25bJQ2sIuBEEpszNn2qGzM5s5Z23XSNyUgLFiAF8Q1KQEVEQ0QsTEgOGlKCZekAdI0GiCPvCiKJDgA17OzC5lWwnXIiTuy2b+85//fN/3X2YOKFTXzN64YOOlWs+4ysECKFR6POwEUFNd9dgkb2VDVQUoc/AMFhoLvn7v2TlIzhhZaSlEWctE0N+XMUwkucYolbNNyZKRjiRTzkAkYUVKxhe3ShwDpKxtYUuxDMqfaIlSogKDvCgIQTUSTqcVnljNKzFTVpSCPM9rSkgO8aqW5gVA1hHKwYSJsGziKMUBNkwDjub4FMdJbEgSeEbgxJWUfzm0kW6ZxIUBVMyFK7l77TKs14cqIwRtTIJQsUR8XrI9nmiZ25aaEyiLFSvpkMQyzqGRT82WCv3LZSMHr38Mcr2lZE5RIEJUIFY8YWRQKX4FzG3Ad6VmgypUABCFiBIEIZYbEynnWXZGxtfH4Vh0ldZcVwmaWMf5GylK1EivhQouPbWREIkWv/O3JCcbuqZDO0rNbYo/Fe/ooGKLdNmWUXeKboUQt1oWpjuWttAhlhdgWAtxtMopvBhOi6WDitFKMo86qdkyVd0RDfnbLNwECWo4WhtQpg1xajfb7biGHUTDfkIKgCsasmClk9RiFnO423TyCjNECL/7eOMMDO/G2NbTOQyHI4xecCWKUnI2q6vU6EW3Fkvl04eiVDfGWSkQ6O3tZXp5xrK7AhwAbGDF4tak0g0zMkV8nV4v+us33kDrLhUFkp1Il3A+S7D0kVolAMwuKsaJQZ4PlnQfCSs22vovQxnnwMiOGKsO4TghrKos6Q1F4LmwOBYdEisVacDBAdNyns7Idg/EWUNWIK2QOstloK2rEh/UOD6sQVoVIxotRDSNTgdVkWY1CAGEZDhGwv+nRrnZUk8qVhZ2WIau5Mek4Mes2Hlb7ZBtnE9CwyCGm636a5JEDsm7Ts/p9Vui6MRAJIic1RmnthnFygQsmQw1x9Tpor4j3jp5H95XSSUEi0x1tfgiY1y6DHpWYWyIrJxN3uFMuzPXU1YPNEmXYNsyDGgvZ+9IibGb6Pdoml+TlWLoRMbO+43ZLY7J26xtGd9D1r5+z6prMGeDbETgyMTm74hbs5vXVP4/GFq3lNgFFsJQvQsfIIGR16FYhftj+z0HQb9nP7lRgQCYxc4EM6q9y3zeiQ1Ix5DRZY1BepdJvvJtyPTAfFbW7cpqz6ppH77bWXYBG3wG1A9fwWq87ISy+xiYdnWlin3goVo2DDiO5zg2JPArwcyrqz52qm+KdGqJ9Meuuj2Pt1Evrv9656wDm56vArXDTh5PVQWpjIrvHqxTqz+bePLS6tA3R47x+7595+fJ3qnhiwfrL+z95YNJHzU++dpeuOXHXbKYXHgMto0Tz/26un7c+vNdm89v3L7hlUePe+q3DO37Ijo9o6z68tiaH9Zd6hEHPv0rMDj/75ZPQN+JbW9y04d2DnRvmCHN/Pzldaff2pM4MH2Z/PvaR+wdwuVd8yYmkpfHgwnskf2Tc5tf3f59g8S2+n+rrRh6uub18fzWc5XowlD1G5sOLXphxewzZ/70deqH+05mX/q4Eew+mwp6M4y9pm4xdzSxp0m5WDBONnU8N/DEwwMzpswunLj806H3B5rfbmlvfe/4NiYiLz3cGJa+qrvAHF04/3TDwlO+3YuEHcX0/QO2WXmBGg8AAA=="
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
