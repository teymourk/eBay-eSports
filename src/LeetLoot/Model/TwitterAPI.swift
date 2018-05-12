//
//  Twitter.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//
//  Contains twitter API function for getting tweets
//

import Foundation
import TwitterKit

public var tweetSize = CGSize()

func getTweet(completion: @escaping (TWTRTweet) -> ()) {
    let client = TWTRAPIClient()
    // Construct URL to query the most recent tweet from the featured event twitter account
    let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
    let params = ["screen_name": "E3", "count": "1"]
    var clientError : NSError?

    let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
    
    // Send tweet request to client
    client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
        if connectionError != nil { print("Error: with Connection") }
        
        do {
            guard let data = data else { return }
            
            guard
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray,
                let dict = json[0] as? NSDictionary,
                let tweetID = dict["id_str"] as? String else { return } // Set tweet id to the id_str variable in the JSON string
            
            // Load the tweet in the Tweet view based on the ID retrieved
            client.loadTweet(withID: tweetID) { (tweet, error) in
                if let t = tweet {
                    DispatchQueue.main.async {
                        completion(t)
                    }
                }
            }
            
        } catch let jsonError as NSError {
            print("json error: \(jsonError.localizedDescription)")
        }
    }
}
