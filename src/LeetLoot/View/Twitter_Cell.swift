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
    
    var tweetSize:CGSize = CGSize()
    
    private lazy var timelineButton: UIButton = {
        let button = UIButton()
        button.setTitle("See more Tweets", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
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
            tweetView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -45),
            
            timelineButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            timelineButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
        ])
        
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["screen_name": "E3", "count": "1"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data!, options: [])
                //print("json: \(json)")
                guard let data = data else { return }
                print(data)
                //let tweetID = try JSONDecoder().decode(main.self, from: data!)
                guard
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray,
                    let dict = json[0] as? NSDictionary,
                    let tweetID = dict["id_str"] as? String else { return }
                
                client.loadTweet(withID: tweetID) { (tweet, error) in
                    if let t = tweet {
                        self.tweetView.configure(with: t)
                        self.setTweetSize(t:self.tweetView)
                    } else {
                        print("Failed to load Tweet: \(error?.localizedDescription)")
                    }
                }
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
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
