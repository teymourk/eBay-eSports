//
//  FilterOptions.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/4/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol FilterOptions {
    var section: String { get }
    var options: [EnumTitles] { get }
}

protocol EnumTitles {
    var title: String { get }
}

extension EnumTitles {
    var title: String {
        return String(describing: self)
    }
}

struct Sort: FilterOptions {
    var options: [EnumTitles] { return [option.All, option.Toys, option.Wow] }
    
    var section: String { return "Sort by" }
    
    enum option: EnumTitles {
        case All, Toys, Wow
    }
}

struct Type: FilterOptions {
    var options: [EnumTitles] { return [option.Kia, option.Me] }
    
    var section: String { return "Filter by" }
    
    enum option: EnumTitles {
        case Kia, Me
    }
}

struct Price: FilterOptions {
    var section: String { return "Price" }
    
    var options: [EnumTitles] {
        return [Price.price]
    }
    
    enum Price: EnumTitles {
        case price
    }
}
