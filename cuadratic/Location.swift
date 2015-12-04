//
//  Location.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var address: String
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var city: String
    @NSManaged var state: String
    @NSManaged var country: String
    @NSManaged var formattedAddress: [String]
    
    // Relationship Data
    @NSManaged var venue: Venue
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String: AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        address = (dictionary["address"] as? String) ?? "NA"
        lat = (dictionary["lat"] as? Double) ?? 0.0
        lon = (dictionary["lng"] as? Double) ?? 0.0
        city = (dictionary["city"] as? String) ?? "NA"
        state = (dictionary["state"] as? String) ?? "NA"
        country = (dictionary["country"] as? String) ?? "NA"
        formattedAddress = (dictionary["formattedAddress"] as? [String]) ?? ["NA"]
    }
    
    init(object: Location, context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Location", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        address = object.address
        lat = object.lat
        lon = object.lon
        city = object.city
        state = object.state
        country = object.country
        formattedAddress = object.formattedAddress
    }
    
    var fullLocationString: String {
        get {
            var locationString: String = ""
            for address in formattedAddress {
                locationString += " \(address)"
            }
            return locationString
        }
    }

}