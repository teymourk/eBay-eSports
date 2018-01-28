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


class Home: UICollectionViewController,FUIAuthDelegate {
    
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
        collectionView?.backgroundColor = UIColor(red: 238, green: 239, blue: 241)
        collectionView?.register(Featured_Events_Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.register(Favorites_Cell.self, forCellWithReuseIdentifier: "Cells")
        collectionView?.register(Home_Header_Cell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Cells")
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}

