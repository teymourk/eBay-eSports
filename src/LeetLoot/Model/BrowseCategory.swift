//
//  BrowseCategory.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/23/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class BrowseCategory: NSObject {
    
    var name: String?
    var imageName: String?
    var categories: [Categories]?

    
    static func sampleBrowseCategories() -> [BrowseCategory] {
        let eventsCategory = BrowseCategory()
        eventsCategory.name = "Events"
        eventsCategory.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/events.png?alt=media&token=69453696-0b77-4994-a397-37ab38f78f3b"
        
        eventsCategory.categories = Categories.eventCategories()
        
        let gamesCategory = BrowseCategory()
        gamesCategory.name = "Games"
        gamesCategory.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/games.jpg?alt=media&token=bec14f2c-f66e-42fd-b697-c8d2b45cd4cf"
        
        gamesCategory.categories = Categories.gameCategories()

        
        return [eventsCategory, gamesCategory]
    }
}

class Categories: NSObject {
    var id : NSNumber?
    var imageName: String?
    
    
    static func eventCategories() -> [Categories] {
        var categories = [Categories]()
        
        let e3 = Categories()
        e3.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/e3browse.png?alt=media&token=dc7eca57-6c2b-4cb1-8d9a-8f98167fa6ee"
        categories.append(e3)
        
        let gamescon = Categories()
        gamescon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/gamesconBrowse.jpg?alt=media&token=e31ff162-7bb1-43d8-b9b5-f84347f5d430"
        categories.append(gamescon)
        
        let pax = Categories()
        pax.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/paxBrowse.png?alt=media&token=8ac86422-b0cd-4c0d-90e0-1c2d0de1fd08"
        categories.append(pax)
        
        let twitchcon = Categories()
        twitchcon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchconBrowse.png?alt=media&token=7a9756cc-0b83-4437-aeed-d4420749b3c8"
        categories.append(twitchcon)
        
        let blizzcon = Categories()
        blizzcon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/blizzconBrowse.jpg?alt=media&token=47479430-be8b-4aad-8377-773a3d3a9cd9"
        categories.append(blizzcon)
        
        return categories
    }
    
    static func gameCategories() -> [Categories] {
        var categories = [Categories]()
        
        let overwatch = Categories()
        overwatch.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/owBrowse.png?alt=media&token=5fff142d-b71f-4d4a-b3b0-aeca81931b11"
        categories.append(overwatch)
        
        let lol = Categories()
        lol.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/lolBrowse.jpg?alt=media&token=104a0833-160d-47d5-a06a-341791177e9a"
        categories.append(lol)
        
        let dota = Categories()
        dota.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/dotaBrowse.png?alt=media&token=b523839f-69d3-4d9d-9b3f-bd29f7df5a22"
        categories.append(dota)
        
        let sbm = Categories()
        sbm.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/sbmBrowse.jpeg?alt=media&token=c080f984-0664-402f-9450-d6bc77570800"
        categories.append(sbm)
        
        let sf = Categories()
        sf.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/sfBrowse.png?alt=media&token=e8b423e0-cf1f-4b17-a0d5-8a89cef586e4"
        categories.append(sf)
        
        let rl = Categories()
        rl.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/rlBrowse.jpeg?alt=media&token=b4d9d1d6-f290-4158-a37d-970e9aa1fd2a"
        categories.append(rl)
        
        let csgo = Categories()
        csgo.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/csgoBrowse.png?alt=media&token=7415cb25-53d1-4f59-b6c6-d64e7ca3d549"
        categories.append(csgo)
        
        let hots = Categories()
        hots.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/hotsBrowse.jpeg?alt=media&token=c5e713ff-d417-4277-b375-64e491b9b8a9"
        categories.append(hots)
        
        let sc2 = Categories()
        sc2.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/scBrowse.jpeg?alt=media&token=cc174e40-2548-40c0-824c-b0b6334d4378"
        categories.append(sc2)
        
        let hs = Categories()
        hs.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/hsBrowse.jpeg?alt=media&token=9f234459-227e-4048-8b88-91b8c192e052"
        categories.append(hs)
        
        
        return categories
    }
    
}

