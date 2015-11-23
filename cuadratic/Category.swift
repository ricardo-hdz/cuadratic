//
//  Category.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class Category {
    var name: String = "NA"
    var icon: String = "NA"
    
    init (dictionary: [[String: AnyObject]]) {
        for category in dictionary {
            if let _ = category["primary"] as? Bool {
                name = category["name"] as! String
                let iconObject = category["icon"] as! [String: String]
                icon = iconObject["prefix"]! + iconObject["suffix"]!
            }
        }
    }
}