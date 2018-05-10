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
    //var user: userInfo?

    
    static func sampleBrowseCategories() -> [BrowseCategory] {
        let eventsCategory = BrowseCategory()
        eventsCategory.name = "Events"
        eventsCategory.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/events.png?alt=media&token=69453696-0b77-4994-a397-37ab38f78f3b"
        
        eventsCategory.categories = Categories.eventCategories()
        //eventsCategory.user = userInfo()
        
        let gamesCategory = BrowseCategory()
        gamesCategory.name = "Games"
        gamesCategory.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/games.jpg?alt=media&token=bec14f2c-f66e-42fd-b697-c8d2b45cd4cf"
        
        gamesCategory.categories = Categories.gameCategories()
        //gamesCategory.user = userInfo()
        
        return [eventsCategory, gamesCategory]
    }
}

class Categories: NSObject {
    var id : String?
    var imageName: String?
    var type: String?
    var date: String?
    var location: String?
    
    static func eventCategories() -> [Categories] {
        var categories = [Categories]()
        
        let e3 = Categories()
        e3.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/e3Browse.png?alt=media&token=8a59b679-d03d-4b78-9341-e1e36aff883c"
        e3.type = "event"
        e3.id = "E3 Expo"
        e3.date = "June 12 - June 14"
        e3.location = "Los Angeles, California"
        categories.append(e3)
        
        let gamescon = Categories()
        gamescon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/gamesconBrowse.jpg?alt=media&token=e31ff162-7bb1-43d8-b9b5-f84347f5d430"
        gamescon.type = "event"
        gamescon.id = "Gamescom"
        gamescon.date = "Aug 21 - Aug 25"
        gamescon.location = "Cologne, Germany"
        categories.append(gamescon)
        
        let pax = Categories()
        pax.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/paxBrowse.png?alt=media&token=8ac86422-b0cd-4c0d-90e0-1c2d0de1fd08"
        pax.type = "event"
        pax.id = "Pax West"
        pax.date = "Aug 31 - Sep 3"
        pax.location = "Seattle, Washington"
        categories.append(pax)
        
        let twitchcon = Categories()
        twitchcon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchconBrowse2.png?alt=media&token=b5c487a3-a2a5-4d37-8aaf-67068844dc06"
        twitchcon.type = "event"
        twitchcon.id = "Twitchcon"
        twitchcon.date = "Oct 26 – Oct 28"
        twitchcon.location = "San Jose, California"
        categories.append(twitchcon)
        
        let blizzcon = Categories()
        blizzcon.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/blizzconBrowse.jpg?alt=media&token=47479430-be8b-4aad-8377-773a3d3a9cd9"
        blizzcon.type = "event"
        blizzcon.id = "Blizzcon"
        blizzcon.date = "Nov 2 - Nov 3"
        blizzcon.location = "Anaheim, California"
        categories.append(blizzcon)
        
        return categories
    }
    
    static func gameCategories() -> [Categories] {
        var categories = [Categories]()
        
        let overwatch = Categories()
        overwatch.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Foverwatch.jpg?alt=media&token=09538ec7-3063-435f-b9fd-09741ae7b999"
        overwatch.type = "game"
        overwatch.id = "overwatch"
        categories.append(overwatch)
        
        let lol = Categories()
        lol.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Flol.jpg?alt=media&token=8c35d4d5-5e0a-47ce-b946-cb5241ed134d"
        lol.type = "game"
        lol.id = "lol"
        categories.append(lol)
        
        let dota = Categories()
        dota.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fdota2.jpg?alt=media&token=3cf0e7e2-7ddc-415b-af87-3e3a9c91d905"
        dota.type = "game"
        dota.id = "dota"
        categories.append(dota)
        
        let sbm = Categories()
        sbm.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fssbm.jpg?alt=media&token=2dff8e1e-8a1e-4152-a74b-adf5889707a1"
        sbm.type = "game"
        sbm.id = "sbm"
        categories.append(sbm)
        
        let sf = Categories()
        sf.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fstreetfighter5.jpg?alt=media&token=8488d7de-b29e-4117-98b4-c53ec1e1f529"
        sf.type = "game"
        sf.id = "sf"
        categories.append(sf)
        
        let rl = Categories()
        rl.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Frocketleague.jpg?alt=media&token=b6bfe824-fd63-4c98-a922-7b11bace016d"
        rl.type = "game"
        rl.id = "rl"
        categories.append(rl)
        
        let csgo = Categories()
        csgo.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fcsgo.jpg?alt=media&token=f713fd87-6e71-4286-819a-11a504c6ccf3"
        csgo.type = "game"
        csgo.id = "csgp"
        categories.append(csgo)
        
        let hots = Categories()
        hots.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fhots.jpg?alt=media&token=76f2770b-9c75-4233-9ecd-375d7065f1c4"
        hots.type = "game"
        hots.id = "hots"
        categories.append(hots)
        
        let sc2 = Categories()
        sc2.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fstarcraft2.jpg?alt=media&token=107d477f-4f31-43dc-9132-4f311f4b3bfe"
        sc2.type = "game"
        sc2.id = "sc2"
        categories.append(sc2)
        
        let hs = Categories()
        hs.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fhearthstone.jpg?alt=media&token=cf9df87d-b75f-45a0-ac02-2978b7b7e8f8"
        hs.type = "game"
        hs.id = "hs"
        categories.append(hs)
        
        
        return categories
    }
}

