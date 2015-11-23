//
//  Stats.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class Stats {
    var checkinsCount: Int
    var usersCount: Int
    var tipCount: Int
    
    init(dictionary: [String: AnyObject]) {
        checkinsCount = (dictionary["checkinsCount"] as? Int)!
        usersCount = (dictionary["usersCount"] as? Int)!
        tipCount = (dictionary["tipCount"] as? Int)!
    }

}