//
//  Stats.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class Stats:NSObject {
    var totalCheckins: Int
    var twitterCheckins: Int
    var facebookCheckins: Int
    var maleCheckins: Int
    var femaleCheckins: Int
    var ageBreakdown: [NSDictionary]
    var hourBreakdown: [NSDictionary]
    
    init(dictionary: [String: AnyObject]) {
        totalCheckins = dictionary["totalCheckins"] as! Int
        twitterCheckins = dictionary["twitterCheckins"] as! Int
        facebookCheckins = dictionary["facebookCheckins"] as! Int
        maleCheckins = dictionary["maleCheckins"] as! Int
        femaleCheckins = dictionary["femaleCheckins"] as! Int
        ageBreakdown = dictionary["ageBreakdown"] as! [NSDictionary]
        hourBreakdown = dictionary["hourBreakdown"] as! [NSDictionary]
    }

}