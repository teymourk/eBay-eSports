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

class UserInfo: NSObject {
    
    var userID: String?
    var favorites: [String]?
    
    static func grabUserInfo() -> UserInfo{
        let userInfo = UserInfo()
        let user = Auth.auth().currentUser
        userInfo.userID = user?.uid
        
        //query database to find favorites, put into array
        
        //userInfo.favorites = ["ex1", "ex2"]
        return userInfo
        
        /*Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                userId = user.uid
                
                //var rootRef = Database.database().reference();
                //var usersRef = rootRef.child("users");
                
                //usersRef.isEqual(rootRef);  // false
                //usersRef.isEqual(rootRef.child("users"));  // true
                //usersRef.parent.isEqual(rootRef);  // true
                
            } else {
                //userId = nil
                //favorites = nil
                //print ("no user is logged in")
            }*/
    }
}
