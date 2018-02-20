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
import FirebaseAuthUI


class Home: UICollectionViewController, FUIAuthDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
        setupCollectionView()
    }
     //handle = Auth.auth().addStateDidChangeListener { (auth, user) in
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if let user = user {
            print(user.displayName ?? "no name?")
        }
        if let error = error {
            print(error)
        }
    }
    /*func logoutUser(_ sender: AnyObject) {
        try Auth.auth()!.signOut();
    }*/
    private func setupCollectionView() {
        collectionView?.backgroundColor = .customGray
        collectionView?.registerCell(Featured_Events_Cell.self)
        collectionView?.registerCell(Twitter_Cell.self)
        collectionView?.registerCell(Favorites_Cell.self)
        collectionView?.registerCell(Header_Cell.self, isHeader: true)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
    
    private func setupTwitter() {
        
    }
}

