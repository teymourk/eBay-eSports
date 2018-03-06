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
        return "v^1.1#i^1#I^3#p^1#r^0#f^0#t^H4sIAAAAAAAAAOVXbWwURRjuXT8EaiUxIKYpciwYsGb3ZnfvrtuFu3jQApXSFu7aSCk0c7uz7crd7rEzZ3sqeGkiCTQKSiIhNVhQqKAmtMEfENEfBvyKgYAao78kYjBGIx8CMZo4u3eUayV8FiHx/lzmnXfeeZ7nfd+ZHZApGV+5ftH6i2Wu+9z9GZBxu1x8KRhfUvz4A4Xu8uICkOfg6s/MzBT1FJ6ei2EinpSXIZw0DYw83Ym4gWXHGGRSliGbEOtYNmACYZkociS8pF4WOCAnLZOYihlnPHU1QYaXVEHjNSD5RVGRJIFajcsxo2aQiUmi6JN4P4BqVSAm8XQe4xSqMzCBBgkyAuAlFogs8EcFURYEGfi4APC1Mp4WZGHdNKgLB5iQA1d21lp5WK8NFWKMLEKDMKG68IJIY7iuprYhOtebFyuU0yFCIEnhkaP5poo8LTCeQtfeBjveciSlKAhjxhvK7jAyqBy+DOYW4DtSS35YBQKQB4JarUBJGRMpF5hWApJr47AtuspqjquMDKKT9PUUpWrEnkYKyY0aaIi6Go/9tzQF47qmIyvI1M4LLw83NTGhxTq0IO6MsvUIkXrTJGzTshq2ihd9SNKqBFYVFDEgxQK5jbLRcjKP2mm+aai6LRr2NJhkHqKo0Wht+DxtqFOj0WiFNWIjGvYLRAGf09Bf7W+1k5rNYop0GnZeUYIK4XGG18/A8GpCLD2WImg4wugJR6IgA5NJXWVGTzq1mCufbhxkOglJyl5vV1cX1yVyptXhFQDgvU8tqY8onSgBGepr93rWX7/+AlZ3qCiIrsS6TNJJiqWb1ioFYHQwISFA29yf030krNBo678MeZy9IztirDpEkXwA0HpBVUAQIFLHokNCuSL12jhQDKbZBLRWI5KMQwWxCq2zVAJZuiqLfk0QJQ2xaqBaY33VmsbG/GqA5TWEAEKxmFIt/Z8a5UZLPaKYSdRkxnUlPSYFP2bFLlpqE7RIOoLicWq40aq/Kklsk7zj9OxevymKdgxMg8Ckztm1zSlmwmtCeqjZpnYH9W3x1ul9eE8llRLMMtXV7EXGOXQ5/IzCWQibKYve4Vyjfa5HzdXIoF1CLDMeR1YLf1tKjN2JfpdO86uyUuI6lbH9XmN2k8fkLdY2JHeRdVGPa8VVmPN+AQjVAi/4bovbfCev0fR/cGjdVGIXmZgg9Q58gHhHPodCBc6P73G9D3pcg/RFBbzgUX4GmF5S2FxUeH851gnidKhxWO8w6Fe+hbjVKJ2EuuUuca2o2LenPe8B1r8SPDz8BBtfyJfmvcdAxZWZYn7ilDJeAiLwC6Ig0GsXzLgyW8Q/VDSptHdc796mWfpu79Fxhze63+1TeiaAsmEnl6u4gFZGQcn+DW3CtD+LM56Ye9fnqvnbwPZL5ws/PHdq27kftpIF8Z4Thz5dcfq9vWtOvXRp9sWBX84s/rYj88iGWSeeW7W2fvKxb/64oL91vP35Lz1r+7qPvLKQvHPmsSNbp363udJdNmn3gYGhY3WbHrzAL//6/I49J8q3/Vp6srdl1c+D05fWrGtYMq32k8qZ7Svbas9g72uvfyytX1sxNPim72Bbwca9P5ZvDg2enVy68+xHyb/xX2/v+F16cteU1s+2r5k6QcusfONY5RMvHlo8MNAmDU3ZVzl99vHWLw4EP9hTsb+v+ULRulWzKn6auq73/MFXt8xp/v6r5peHDid8zZfmlE7cUHZyoec42NIv73zh8I5nj2bT9w+dKzbQGg8AAA=="
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
    
    var loadingIndicator = { () -> UIActivityIndicatorView in
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.color = .coolGrey
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private var imageURLStringCheck: String?
    private var imageCache = NSCache<NSString, UIImage>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIndicatorLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupIndicatorLayout() {
        self.alpha = 0
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func loadWithAnimation() {
        self.loadingIndicator.stopAnimating()
        self.handleCellAnimation()
    }
    
    func downloadImages(url: String) {
        loadingIndicator.startAnimating()
        self.image = nil
        self.imageURLStringCheck = url
        
        let urlString = NSString(string: url)

        if let cachedImage = imageCache.object(forKey: urlString) {
            self.loadWithAnimation()
            self.image = cachedImage
            return
        }
        
        guard let imageURL = URL(string: url) else {
            self.loadWithAnimation()
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
                            self?.loadWithAnimation()
                            self?.image = cachedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
