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
        return "v^1.1#i^1#p^1#r^0#I^3#f^0#t^H4sIAAAAAAAAAOVXa2wUVRTu9kUKVEosUJDHOmCiwMzemdmd3R3ZjUuX2g19ybYNlGiZnblDx+7OTObepV1MsFZsQkiMIf5QadLGBwT1B6ioP4gmJo0QDKE24RGNAX8YQCBWJBqJxjuzS9lWwrMIiTs/NnPuueee7zvfuXcu6CktW9pX2/d7uWtK4WAP6Cl0udhpoKy0ZNlDRYXzSgpAnoNrsGdJT3Fv0ZkVSEolTXENRKahI+juTiV1JDrGEJW2dNGQkIZEXUpBJGJZjEfq60SOAaJpGdiQjSTljkVDFKsEvD6O83G8X/YBRSJW/WrMZiNEBRKC4vNyIGB7eBOAjCOUhjEdYUnHIYoDbIAGHM2BZsCLLC96AcPzXBvlboUW0gyduDCACjvpis5cKy/XG6cqIQQtTIJQ4VikJt4YiUVXNTSv8OTFCud4iGMJp9H4t2pDge5WKZmGN14GOd5iPC3LECHKE86uMD6oGLmazB2k71CteoUAK5OHU+SgAIRJobLGsFISvnEetkVTaNVxFaGONZy5GaOEjcTzUMa5twYSIhZ123/PpKWkpmrQClGrVkbWRZqaqPBqTbIk1NFM10GI6wwD001rorSf5b0woPo5WuFkXiBSyi2UjZajecJK1YauaDZpyN1g4JWQZA0ncgPyuCFOjXqjFVGxnVG+n+8qhxzfZhc1W8U07tDtusIUIcLtvN68AmOzMba0RBrDsQgTBxyKQpRkmppCTRx0tJiTTzcKUR0Ym6LH09XVxXTxjGFt9HAAsJ619XVxuQOmSDN2p+xez/prN59Aaw4UGZKZSBNxxiS5dBOtkgT0jVSYE3w878vxPj6t8ETrvwx5mD3jO2KyOgQGAz5eELx+WRCkRCIxGR0SzonUY+cBE1KGTklWJ8RmUpIhLROdpVPQ0hSR96kcH1AhrQhBlfYGVZVO+BSBZlUIAYSJhBwM/J8a5ValHpcNEzYZSU3OTIrgJ03svKU0SRbOxGEySQy3qvrrgkQ2yHsOz+7124Jox0AkiGRqjK1tRjZSHkMim5ptaneyvivcGjkPH6iiEoBZpJqSPcgYBy6DNsmMBZGRtsgZzjTa+3qz0Ql10iXYMpJJaLWyd8XE5O3o92k3vy4qOakRGtsfNGS3uU3eobYlfB9RF/e61l8HOetjgyAokC/uu8JW7dS1OfMfbFq3VdhaA2Go3IMPEM/461C4wPmxva79oNe1j9yogAc8xi4Gj5YWtRQXTZ+HNAwZTVIZpG3UyVe+BZlOmDElzSosda2fv3dPe94FbPBZUDV2BSsrYqfl3cfA/GsjJeyMOeVsAHCEFJ6IFbSBxddGi9nZxZWvLNnTVzL8m9+/rGLTjt1bv908fOAiKB9zcrlKCogyCt4+1n5k4ZMLPtp7fPWI+f7g1u920i/6pxqVZzd/uevc/urzUx8frZhxbNny/toNzOzRg21rZo3stLZsunLlr/qjsZeG6KrKHyo/4D97OFQ1+ol0kYZPzd09feS49HXfUEvNdh/Fz41+v6hmTtmJ1/kt6W/Q0pnLjy+6cPhCTz9zavisuWvRn2tXnS8/WYjNXwY+3fJx/baoOuvX1PqFRUfeuHw6tYMejAR2Vj13aV3w3aFDfQtPHMAna/2XdoidI9urnj46/AT88dXDZ06/EN23unGUYZvOvTeT+vzUW1MWzLy8be7BodJDjwwMfPHVzw1L973zWvjNig2xir/39BuzSj483Ppy409Wyx/pltPZ8v0DlClIWhoPAAA="
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
                
                if let imgData = data {
                    DispatchQueue.main.async {
                        let cachedImage = UIImage(data: imgData)
                        self.imageCache.setObject(cachedImage!, forKey: urlString)
                        self.image = cachedImage
                    }
                }
            }.resume()
        }
    }
}
