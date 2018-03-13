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
        //self.favorites = nil
        //createFavorites()
        
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

/*
class userInfo {
    var userID: String?
    var favorites = [String]()
    
    static func createInfo() -> userInfo{
        let user = userInfo()
        user.userID = Auth.auth().currentUser?.uid
        //user.favorites = nil
        Database.database().reference().child("users").child(user.userID!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let items = snapshot.value as? [String:Bool]{
                let val = items.filter({ $0.value == true })
                for value in val{
                    //print(value.key)
                    user.favorites.append(value.key)
                }
                
                //print(val)
                
            }
        }, withCancel: nil)
        
        //print("users favorites are: ", user.favorites)
        return user
    }
}
*/

/*
struct userInfo {
    let userID: String?
    var favorites: [String]?
    
    init(userID: String? = nil, favorites: [String]? = nil) {
        let user = Auth.auth().currentUser
        self.userID = user?.uid
        //self.favorites = nil
        self.favorites = createFavorites()
      
    }
    
    func createFavorites() -> [String]? {
        var fav:[String]?
        Database.database().reference().child("users").child(self.userID!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let items = snapshot.value as? [String:Bool]{
                let val = items.filter({ $0.value == true })
                for value in val{
                    //print(value.key)
                    fav?.append(value.key)
                }
                
                print(val)
                
            }
        }, withCancel: nil)
        
        return fav
    }
    
    
}*/

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
