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
    let userID: String
    let favorites: [String]?
    
    init() {
        let user = Auth.auth().currentUser
        if user != nil{
            userID = (user?.uid)!
        }
        else {
            userID = ""
        }
        favorites = nil
        /*let ref = Database.database().reference()
        let favorite = ref.child("users").queryOrdered(byChild: "users")*/
    
        //print ("favorites are: ", favorite)

    }
    
    
}

/*class UserInfo: NSObject {
    
    var userID: String?
    var favorites: [String]?
    
    static func grabUserInfo() -> UserInfo{
        let userInfo = UserInfo()
        let user = Auth.auth().currentUser
        userInfo.userID = user?.uid
        
        let ref = Database.database().reference()
        let databaseStuff = ref.child("users").queryOrdered(byChild: "users")
        print ("data stuff is: ", databaseStuff)

        
        //query database to find favorites, put into array
        
        //userInfo.favorites = ["ex1", "ex2"]
        userInfo.favorites = nil

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
}*/
