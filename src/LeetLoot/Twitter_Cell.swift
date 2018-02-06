//
//  Twitter_Cell.swift
//  LeetLoot
//
//  Created by Will on 2/2/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import TwitterKit

class Twitter_Cell: ParentCell, TWTRTweetViewDelegate{
    
    lazy var tweetView:TWTRTweetView = {
        let tweetView = TWTRTweetView()
        tweetView.translatesAutoresizingMaskIntoConstraints = false;
        return tweetView;
    }()
    
    var tweetSize:CGSize = CGSize()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        addSubview(tweetView);
        backgroundColor = .white
        NSLayoutConstraint.activate([
            tweetView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            tweetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tweetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        
        // Swift
        let client = TWTRAPIClient()
        client.loadTweet(withID: "959124212198686720") { (tweet, error) in
            if let t = tweet {
                self.tweetView.configure(with: t)
                self.setTweetSize(t:self.tweetView)
            } else {
                print("Failed to load Tweet: \(error?.localizedDescription)")
            }
        }
    }
    
    private func setTweetSize(t:TWTRTweetView ) -> Void {
        tweetSize = t.sizeThatFits(t.frame.size)
    }
    
    public func getTweetSize() -> CGSize {
        return tweetSize
    }
}
