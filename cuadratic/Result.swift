//
//  Result.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class Result: NSObject {
    var title: String
    var location: String
    var type: String
    var thumbnail: UIImage
    var isFavorite: Bool
    
    init(dictionary: [String: AnyObject]) {
        title = dictionary["title"] as! String
        location = dictionary["location"] as! String
        type = dictionary["type"] as! String
        thumbnail = dictionary["thumbnail"] as! UIImage
        isFavorite = dictionary["isFavorite"] as! Bool
    }
    
}