//
//  UserInfo.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/8/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

struct userInfo {
    let userID: String?
    var favorites: [String]?
    
    init(userID: String? = nil, favorites: [String]? = nil) {
        let user = Auth.auth().currentUser
        self.userID = user?.uid

        
    }
    
    func createFavorites(completionHandler: @escaping ([String]) -> Void) {
        var fav = [String]()
        Database.database().reference().child("users").child(self.userID!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let items = snapshot.value as? [String:Bool]{
                let val = items.filter({ $0.value == true })
                for value in val{
                    //print(value.key)
                    fav.append(value.key)
                }
                DispatchQueue.main.async {
                    completionHandler(fav)
                }
                //print(val)
                
            }
        }, withCancel: nil)
        
        //return fav
    }
    
    
}

