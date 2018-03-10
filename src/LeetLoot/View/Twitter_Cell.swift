//
//  Twitter_Cell.swift
//  LeetLoot
//
//  Created by Will on 2/2/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import TwitterKit

protocol TwitterDelegate: class {
    func showTwitterTimeline()
}

class Twitter_Cell: ParentCell, TWTRTweetViewDelegate{
    
    private lazy var timelineButton: UIButton = {
        let button = UIButton(title: "See more tweets", imageName: #imageLiteral(resourceName: "Arrow"))
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 111).isActive = true
        button.imageView?.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
        
        return button;
    }()
    
    lazy var tweetView:TWTRTweetView = {
        let tweetView = TWTRTweetView()
        tweetView.translatesAutoresizingMaskIntoConstraints = false;
        return tweetView;
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func setupView() {
        addSubview(tweetView)
        addSubview(timelineButton)
        
        timelineButton.addTarget(self, action: #selector(displayTimeline), for: .touchUpInside)
        
        backgroundColor = .white
        NSLayoutConstraint.activate([
            tweetView.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            tweetView.rightAnchor.constraint(equalTo: rightAnchor, constant: -6),
            tweetView.leftAnchor.constraint(equalTo: leftAnchor),
            tweetView.bottomAnchor.constraint(equalTo: timelineButton.topAnchor),
            
            timelineButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            timelineButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
    }
    
    weak var delegate:TwitterDelegate?
    
    @objc func displayTimeline() {
        if let del = self.delegate {
            del.showTwitterTimeline()
        }
    }

}
