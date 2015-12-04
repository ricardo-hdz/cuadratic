//
//  Category.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData

class Category:NSManagedObject {
    
    @NSManaged var name: String!
    
    // Relationship Data
    @NSManaged var venue: Venue
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init (dictionary: [[String: AnyObject]], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        for category in dictionary {
            name = category["name"] as! String
            
            if let _ = category["primary"] as? Bool {
                break
            }
        }
    }
}