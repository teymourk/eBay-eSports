//
//  Browse.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


//Mark: - CollectionHeader
extension Browse {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: Header_Cell = collectionView.reusableCell(indexPath: indexPath, kind: kind)
        header.title = indexPath.section == 0 ? "Events" : "Games"
        
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width,
                      height: 40)
    }
}

class Browse: UICollectionViewController, UICollectionViewDelegateFlowLayout, GamesDelegate {
    
    var category: [FavoritesCategory]?
    
    @objc func sendAlert() {
        let alert = UIAlertController(title: "Not Signed In", message: "Sign in to start favoriting games.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func refreshBrowse() {
        self.collectionView?.reloadData()
    }
    
    func updateItems(index: IndexPath) {
        print("index is: ", index)
        self.collectionView?.reloadItems(at: [index])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(sendAlert), name: NSNotification.Name(rawValue: "sendAlertBrowse"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBrowse), name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        category = FavoritesCategory.favoriteCategories()
        setupCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewDidAppear(animated)
        refreshBrowse()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .customGray
        collectionView?.registerCell(Events_Cell.self)
        collectionView?.registerCell(Games_Cell.self)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = (indexPath.item)
        
        let eventsCell: Events_Cell = collectionView.reusableCell(indexPath: indexPath)
            eventsCell.delegate = self
        
        let gamesCell: Games_Cell = collectionView.reusableCell(indexPath: indexPath)
            gamesCell.curGame = category?[index]
            gamesCell.game = category?[index].id
            gamesCell.indexPath = indexPath
            gamesCell.delegate = self
        
        return indexPath.section == 0 ? eventsCell : gamesCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        if indexPath.section == 1 {
            guard   let game = category?[indexPath.item] else { return }
                    let browse = Browse_Game(collectionViewLayout: UICollectionViewFlowLayout())
                        browse.selectedGame = game.name
                        browse.gameId = game.id
            
            let cell = collectionView.cellForItem(at: indexPath) as? Games_Cell
                browse.buttonIsSelected = cell?.heartView.tintColor
            navigationController?.pushViewController(browse, animated: true)
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 160)
                
        }
        
        return CGSize(width: view.frame.width, height: 64)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(2)
    }
}

//Mark: - EventCell Delegate
extension Browse: EventCategoryDelegate {
    func onEvent(_ events: Categories) {
        let evenPage = Browse_Event(collectionViewLayout: UICollectionViewFlowLayout())
            evenPage.selectedGame = events.id
            evenPage.eventHeader.eventDetails = events
        navigationController?.pushViewController(evenPage, animated: true)
    }
}
