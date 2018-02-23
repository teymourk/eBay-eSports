//
//  ViewController.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/10/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import TwitterKit

class Home: UICollectionViewController, UICollectionViewDelegateFlowLayout, TwitterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private var tweetSize = CGSize()
    
    func getCell(completion: @escaping (TWTRTweet) -> ()) {
        let client = TWTRAPIClient()
        //Construct URL to query the most recent tweet from the featured event twitter account
        let statusesShowEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
        let params = ["screen_name": "E3", "count": "1"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil { print("Error: with Connection") }
            
            do {
                guard let data = data else { return }
                
                guard
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSArray,
                    let dict = json[0] as? NSDictionary,
                    let tweetID = dict["id_str"] as? String else { return }
                
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

    private func setupCollectionView() {
        collectionView?.backgroundColor = .customGray
        collectionView?.registerCell(Featured_Events_Cell.self)
        collectionView?.registerCell(Twitter_Cell.self)
        collectionView?.registerCell(Favorites_Cell.self)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let featuredEventsCell: Featured_Events_Cell = collectionView.reusableCell(indexPath: indexPath)
            featuredEventsCell.delegate = self
        let twitterCell: Twitter_Cell = collectionView.reusableCell(indexPath: indexPath)
            twitterCell.delegate = self
        let favoritesCell: Favorites_Cell = collectionView.reusableCell(indexPath: indexPath)
        
        if indexPath.section == 0 {
            return indexPath.row == 0 ? featuredEventsCell : setupTwitterFor(twitterCell)
        }
    
        return favoritesCell
    }
    
    private func setupTwitterFor(_ cell: Twitter_Cell) -> Twitter_Cell {
        self.getCell(completion: { [weak self] (tweet) in
            cell.tweetView.configure(with: tweet)
            self?.tweetSize = cell.tweetView.sizeThatFits(cell.frame.size)
            self?.tweetSize.width = Constants.kWidth
            self?.collectionView?.collectionViewLayout.invalidateLayout()
        })
        return cell
    }
    
    func showTwitterTimeline() {
        let twitterTimeline = Twitter_Timeline()
        self.navigationController?.pushViewController(twitterTimeline, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0, indexPath.item == 0 {
            let layout = UICollectionViewFlowLayout()
            let myPge = Browse_Game(collectionViewLayout: layout)
            navigationController?.pushViewController(myPge, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        var cellHeight = CGFloat(325)
        if (screenWidth > 375) {
            cellHeight = CGFloat(338)
        }
        
        let eventRow = CGSize(width: view.frame.width, height: cellHeight)
        if indexPath.section == 0 {
            return indexPath.row == 0 ? eventRow : self.tweetSize
        }
        
        return CGSize(width: view.frame.width, height: 200)
    }
}

//Mark: FeaturedEventDelegate
extension Home: FeaturedEventDelegate {
    func onEventBanner(_ sender: UITapGestureRecognizer) {
        let layout = UICollectionViewFlowLayout()
        let browseEvent = Browse_Event(collectionViewLayout: layout)
        navigationController?.pushViewController(browseEvent, animated: true)
    }
}

//Mark: - CollectionHeader
extension Home {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: Header_Cell = collectionView.reusableCell(indexPath: indexPath, kind: kind)
        header.title = indexPath.section == 0 ? "Featured Event" : "Favorites"
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 40)
    }
}
