//
//  FavoriteVenue.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import CoreData
import UIKit

class FavoriteVenue:NSManagedObject {
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var category: String
    @NSManaged var thumbnail: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String:AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("FavoriteVenue", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        id = dictionary["id"] as! String
        name = dictionary["name"]! as! String
        location = dictionary["location"]! as! String
        category = dictionary["category"]! as! String
        thumbnail = dictionary["thumbnail"]! as! String
    }
}