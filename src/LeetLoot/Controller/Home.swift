//
//  ViewController.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 12/10/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit
import Firebase
import TwitterKit

class Home: UICollectionViewController, UICollectionViewDelegateFlowLayout, TwitterDelegate {
    
    var size:CGFloat = 46
    
    var favorites: [FavoritesCategory]?
    
    let events = Categories.eventCategories()
    
    var count:Int = 1
    
    var arr: [String]?{
        didSet{
            if (arr!.count > 0) {
                count = arr!.count
            }
            else {
                count = 1
            }
            self.collectionView?.reloadSections(NSIndexSet(index:1) as IndexSet)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshHome), name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.count = 1
        favorites = FavoritesCategory.favoriteCategories()
        grabFavInfo()
    
        Auth.auth().addStateDidChangeListener { auth, user in
            self.refreshHome()
        }
    
        let user = Auth.auth().currentUser?.uid
        if user != nil {
            Database.database().reference().child("users").child(user!).child("favorites").observe(.childChanged, with: { (snapshot) in
            print ("Changes: ", snapshot)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)

        })}
    
        if Reachability.isConnectedToNetwork() {
            print("Internet Connection Available!")
        } else {
            print("Internet Connection not Available!")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        setupCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func grabFavInfo(){
        let user = Auth.auth().currentUser
        if user != nil{
            _ = userInfo().createFavorites { (val) in
                self.arr = val
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
       
        return section == 0 ? 2 : count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let featuredEventsCell: Featured_Events_Cell = collectionView.reusableCell(indexPath: indexPath)
            featuredEventsCell.delegate = self
        let twitterCell: Twitter_Cell = collectionView.reusableCell(indexPath: indexPath)
            twitterCell.delegate = self
        let favoritesCell: Favorites_Cell = collectionView.reusableCell(indexPath: indexPath)
            favoritesCell.userFavorites = arr
        
            if (arr?.count != nil) {
                if (arr!.count > 0){
                    var game:String
                    if arr!.count == 1 {
                        game = arr![0]
                        let index = (indexPath.item)
                        print ("index is: ", index)
                    }
                    else{
                         let index = (indexPath.item)
                        print ("index is: ", index)
                         game = arr![index]
                    }
                   if (favorites != nil){
                        let i = favorites?.index(where: {$0.id == game})
                        favoritesCell.favorites = favorites![i!]
                        favoritesCell.curGame = favorites![i!].id
                    }
                }
            }

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
        
        if Auth.auth().currentUser != nil {
            if let f  = arr{
            if f.count > 0 {
                    print("user signed in with favorites")
                    self.size = CGFloat(244)
                }
                else{
                    print("user signed in with no favorites")
                    self.size = CGFloat(46)
                }
            }
        }
        else {
            print("no user signed in")
            self.size = CGFloat(46)
        }
    
        print("size is: ", size)
        return CGSize(width: view.frame.width, height: size)
    }
    
    @objc func refreshHome() {
        self.count = 1
        self.grabFavInfo()
        self.collectionView?.reloadData()
        self.collectionView?.collectionViewLayout.invalidateLayout()
        //self.collectionView?.reloadSections(NSIndexSet(index:1) as IndexSet)
    }
}

//Mark: FeaturedEventDelegate
extension Home: FeaturedEventDelegate {
    func onEventBanner(_ sender: UITapGestureRecognizer) {
        let layout = UICollectionViewFlowLayout()
        guard let e3 = events.first else { return }
        let browseEvent = Browse_Event(collectionViewLayout: layout)
            browseEvent.selectedGame = e3.id
            browseEvent.eventHeader.eventDetails = e3
        navigationController?.pushViewController(browseEvent, animated: true)
    }
    
    func showFeaturedMerch() {
        let layout = UICollectionViewFlowLayout()
        let browseEvent = Browse_Event(collectionViewLayout: layout)
            browseEvent.selectedGame = "E3 Expo"
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
