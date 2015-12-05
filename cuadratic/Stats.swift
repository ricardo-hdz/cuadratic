//
//  Stats.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData

class Stats:NSManagedObject {
    
    @NSManaged var totalCheckins: Int
    @NSManaged var twitterCheckins: Int
    @NSManaged var facebookCheckins: Int
    @NSManaged var maleCheckins: Int
    @NSManaged var femaleCheckins: Int
    @NSManaged var ageBreakdown: [NSDictionary]
    @NSManaged var hourBreakdown: [NSDictionary]
    
    // Relationship Data
    @NSManaged var venue: Venue
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String: AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Stats", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        totalCheckins = dictionary["totalCheckins"] as! Int
        twitterCheckins = dictionary["twitterCheckins"] as! Int
        facebookCheckins = dictionary["facebookCheckins"] as! Int
        maleCheckins = dictionary["maleCheckins"] as! Int
        femaleCheckins = dictionary["femaleCheckins"] as! Int
        ageBreakdown = dictionary["ageBreakdown"] as! [NSDictionary]
        hourBreakdown = dictionary["hourBreakdown"] as! [NSDictionary]
    }
    
    func getMaxIdFromBreakdown(breakdown: [NSDictionary], fieldName: String) -> String {
        var result = ""
        var max = 0
        for breakdownObject in breakdown {
            let checkins = breakdownObject.valueForKey("checkins") as! Int
            let field = "\(breakdownObject.valueForKey(fieldName)!)"
            
            if checkins > max {
                result = field
                max = checkins
            } else if checkins == max {
                result = "\(result), \(field)"
            }
        }
        return result
    }

}