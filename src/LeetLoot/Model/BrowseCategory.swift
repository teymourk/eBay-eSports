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
        eventsCategory.imageName = "events"
        
        eventsCategory.categories = Categories.eventCategories()
        
        let gamesCategory = BrowseCategory()
        gamesCategory.name = "Games"
        gamesCategory.imageName = "games"
        
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
        e3.imageName = "e3browse"
        categories.append(e3)
        
        let gamescon = Categories()
        gamescon.imageName = "gamesconBrowse"
        categories.append(gamescon)
        
        let pax = Categories()
        pax.imageName = "paxBrowse"
        categories.append(pax)
        
        let twitchcon = Categories()
        twitchcon.imageName = "twitchconBrowse"
        categories.append(twitchcon)
        
        let blizzcon = Categories()
        blizzcon.imageName = "blizzconBrowse"
        categories.append(blizzcon)
        
        return categories
    }
    
    static func gameCategories() -> [Categories] {
        var categories = [Categories]()
        
        let overwatch = Categories()
        overwatch.imageName = "owBrowse"
        categories.append(overwatch)
        
        let lol = Categories()
        lol.imageName = "lolBrowse"
        categories.append(lol)
        
        let dota = Categories()
        dota.imageName = "dotaBrowse"
        categories.append(dota)
        
        let sbm = Categories()
        sbm.imageName = "sbmBrowse"
        categories.append(sbm)
        
        let sf = Categories()
        sf.imageName = "sfBrowse"
        categories.append(sf)
        
        let rl = Categories()
        rl.imageName = "rlBrowse"
        categories.append(rl)
        
        let csgo = Categories()
        csgo.imageName = "csgoBrowse"
        categories.append(csgo)
        
        let hots = Categories()
        hots.imageName = "hotsBrowse"
        categories.append(hots)
        
        let sc2 = Categories()
        sc2.imageName = "scBrowse"
        categories.append(sc2)
        
        let hs = Categories()
        hs.imageName = "hsBrowse"
        categories.append(hs)
        
        
        return categories
    }
    
}

