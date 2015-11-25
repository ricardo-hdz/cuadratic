//
//  Venue.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
class Venue {
    var id: String
    var name: String
    var location: Location
    var category: Category
    var stats: Stats
    var photos: [Photo]?
    var thumbnail: UIImage?

    init(dictionary: [String: AnyObject]) {
        id = (dictionary["id"] as? String)!
        name = (dictionary["name"] as? String)!
        category = Category(dictionary: dictionary["categories"] as! [[String:AnyObject]])
        location = (dictionary["location"] as? Location)!
        stats = (dictionary["stats"] as? Stats)!
    }
    
}