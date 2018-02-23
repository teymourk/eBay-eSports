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
        getTweet(completion: { [weak self] (tweet) in
            cell.tweetView.configure(with: tweet)
            tweetSize = cell.tweetView.sizeThatFits(cell.frame.size)
            self?.collectionView?.collectionViewLayout.invalidateLayout()
            cell.tweetView.showBorder = false
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
        var eventHeight = CGFloat(325)
        let tweet = CGSize(width: Constants.kWidth, height: tweetSize.height + CGFloat(40))
       
        if (screenWidth > 375) {
            eventHeight = CGFloat(338)
        }

        let eventRow = CGSize(width: view.frame.width, height: eventHeight)
        if indexPath.section == 0 {
            return indexPath.row == 0 ? eventRow : tweet
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
