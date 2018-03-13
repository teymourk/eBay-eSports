//
//  FavoritesCategory.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/12/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class FavoritesCategory: NSObject {
    var name: String?
    var imageName:String?
    var merchID:String?
    var id:String?
    
    static func favoriteCategories()-> [FavoritesCategory]{
        var favs = [FavoritesCategory]()
        
        let overwatch = FavoritesCategory()
        overwatch.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Foverwatch.jpg?alt=media&token=09538ec7-3063-435f-b9fd-09741ae7b999"
        overwatch.name = "Overwatch"
        overwatch.merchID = ""
        overwatch.id = "overwatch"
        favs.append(overwatch)
        
        let lol = FavoritesCategory()
        lol.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Flol.jpg?alt=media&token=8c35d4d5-5e0a-47ce-b946-cb5241ed134d"
        lol.name = "League of Legends"
        lol.merchID = ""
        lol.id = "lol"
        favs.append(lol)
        
        let dota = FavoritesCategory()
        dota.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fdota2.jpg?alt=media&token=3cf0e7e2-7ddc-415b-af87-3e3a9c91d905"
        dota.name = "Dota 2"
        dota.merchID = ""
        dota.id = "dota"
        favs.append(dota)
        
        let sbm = FavoritesCategory()
        sbm.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fssbm.jpg?alt=media&token=2dff8e1e-8a1e-4152-a74b-adf5889707a1"
        sbm.name = "Super Smash Bros. Melee"
        sbm.merchID = ""
        sbm.id = "sbm"
        favs.append(sbm)
        
        let sf = FavoritesCategory()
        sf.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fstreetfighter5.jpg?alt=media&token=8488d7de-b29e-4117-98b4-c53ec1e1f529"
        sf.name = "Street Fighter V"
        sf.merchID = ""
        sf.id = "sf"
        favs.append(sf)
        
        let rl = FavoritesCategory()
        rl.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Frocketleague.jpg?alt=media&token=b6bfe824-fd63-4c98-a922-7b11bace016d"
        rl.name = "Rocket League"
        rl.merchID = ""
        rl.id = "rl"
        favs.append(rl)
        
        let csgo = FavoritesCategory()
        csgo.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fcsgo.jpg?alt=media&token=f713fd87-6e71-4286-819a-11a504c6ccf3"
        csgo.name = "Counter-Strike: Global Offensive"
        csgo.merchID = ""
        csgo.id = "csgo"
        favs.append(csgo)
        
        let hots = FavoritesCategory()
        hots.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fhots.jpg?alt=media&token=76f2770b-9c75-4233-9ecd-375d7065f1c4"
        hots.name = "Heroes of the Storm"
        hots.merchID = ""
        hots.id = "hots"
        favs.append(hots)
        
        let sc2 = FavoritesCategory()
        sc2.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fstarcraft2.jpg?alt=media&token=107d477f-4f31-43dc-9132-4f311f4b3bfe"
        sc2.name = "Starcraft 2"
        sc2.merchID = ""
        sc2.id = "sc2"
        favs.append(sc2)
        
        let hs = FavoritesCategory()
        hs.imageName = "https://firebasestorage.googleapis.com/v0/b/ebay-esports-app.appspot.com/o/twitchImages%2Fhearthstone.jpg?alt=media&token=cf9df87d-b75f-45a0-ac02-2978b7b7e8f8"
        hs.name = "Hearthstone"
        hs.merchID = ""
        hs.id = "hs"
        favs.append(hs)
        
        
        return favs
        
    }
}
