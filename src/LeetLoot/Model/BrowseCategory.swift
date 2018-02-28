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
    //var categories: [Categories]?
    
    static func sampleBrowseCategories() -> [BrowseCategory] {
        let eventsCategory = BrowseCategory()
        eventsCategory.name = "Events"
        eventsCategory.imageName = "events"
        
        /*var categories = [Categories]()
        
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
        
        eventsCategory.categories = categories*/
        
        
        let gamesCategory = BrowseCategory()
        gamesCategory.name = "Games"
        gamesCategory.imageName = "games"
        
        return [eventsCategory, gamesCategory]
    }
}

class Categories: NSObject {
    var id : NSNumber?
    var imageName: String?
    
    
    static func sampleCategories() -> [Categories] {
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
    
}

