//
//  Photo.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/25/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
import CoreData

class Photo: NSManagedObject {
    @NSManaged var id: String!
    @NSManaged var prefix: String!
    @NSManaged var suffix: String!
    @NSManaged var documentPath: String!
    
    // Relationship Data
    @NSManaged var venue: Venue
    
    struct size {
        static let thumbnail = "36x36"
        static let small = "100x100"
        static let medium = "300x500"
        static let large = "500x500"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String: AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Photo", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        id = dictionary["id"] as! String!
        prefix = dictionary["prefix"] as! String!
        suffix = dictionary["suffix"] as! String!
        if let path = dictionary["documentPath"] as! String! {
            documentPath = path
        } else {
            documentPath = ""
        }
    }
    
    func getUrl(size: String) -> String {
        return prefix + size + suffix
    }
    
    var image: UIImage? {
        get {
            if !documentPath.isEmpty {
                return CacheHelper.getInstance().getImage(self.id)
            }
            return nil
        }
        set {
            documentPath = CacheHelper.getInstance().pathForObject(self.id)
            CacheHelper.getInstance().saveImage(newValue!, id: self.id)
        }
    }
}