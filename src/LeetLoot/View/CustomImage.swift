//
//  CustomImage.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 3/6/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

final class customeImage: UIImageView {
    
    var loadingIndicator = { () -> UIActivityIndicatorView in
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.color = .coolGray
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
            self.image = #imageLiteral(resourceName: "emptyImage")
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            URLSession.shared.dataTask(with: imageURL) {
                (data, response, error) in
                guard error == nil else { return }
                
                if let imgData = data, let cachedImage = UIImage(data: imgData) {
                    DispatchQueue.main.async {
                        self?.alpha = 0
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
    
    private func setupIndicatorLayout() {
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
