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
    
    let client = TWTRAPIClient()
    var tweetSize:CGSize = CGSize()
    var tweetID = "20"
    
    private lazy var timelineButton: UIButton = {
        let button = UIButton(title: "See more tweets", imageName: "Arrow.png")
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
    
            tweetView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            tweetView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            tweetView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            tweetView.bottomAnchor.constraint(equalTo: timelineButton.topAnchor, constant: -8),
            
            timelineButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            timelineButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        //Construct URL to query the most recent tweet from the featured event twitter account
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["screen_name": "E3", "count": "1"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                guard let data = data else { return }

                guard
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray,
                    let dict = json[0] as? NSDictionary,
                    let tweetID = dict["id_str"] as? String else { return }
                
                // Load the tweet in the Tweet view based on the ID retrieved
                self.client.loadTweet(withID: tweetID) { (tweet, error) in
                    if let t = tweet {
                        self.tweetView.configure(with: t)
                        self.setTweetSize(t:self.tweetView)
                        print("In load tweet: ", self.getTweetSize())
                    } else {
                        print("Failed to load Tweet: \(error?.localizedDescription)")
                    }
                }
            
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
        
        tweetSize = tweetView.sizeThatFits(tweetView.frame.size)
        print("Tweet size is: ",tweetSize)
    }
    
    weak var delegate:TwitterDelegate?
    
    @objc func displayTimeline() {
        if let del = self.delegate {
            del.showTwitterTimeline()
        }
    }
    
    private func setTweetSize(t:TWTRTweetView ) -> Void {
        tweetSize = t.sizeThatFits(t.frame.size)
    }
    
    public func getTweetSize() -> CGSize {
        return tweetSize
    }
}
