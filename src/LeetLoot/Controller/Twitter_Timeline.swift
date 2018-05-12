//
//  Twitter_Timeline.swift
//  LeetLoot
//
//  Created by Will on 2/12/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//
//  Contains the twitter timeline view controller associated with the featured event
//

import UIKit
import TwitterKit

class Twitter_Timeline: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "E3" // Set the title of the view controller to E3
        self.dataSource = TWTRUserTimelineDataSource(screenName: "E3", apiClient: TWTRAPIClient()) // Grab the timeline for the E3 account
    }
}
