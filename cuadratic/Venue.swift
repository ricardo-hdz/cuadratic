//
//  Venue.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
import CoreData

class Venue: NSManagedObject {
    
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var verified: Bool

    // Relationship Data
    @NSManaged var favorite: User?
    @NSManaged var location: Location?
    @NSManaged var category: Category?
    @NSManaged var photos: NSOrderedSet?
    @NSManaged var stats: Stats?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    init(dictionary: [String: AnyObject], context: NSManagedObjectContext) {
        let entity = NSEntityDescription.entityForName("Venue", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        id = (dictionary["id"] as? String)!
        name = (dictionary["name"] as? String)!
        
        if let verifiedValue = dictionary["verified"] as? Bool {
            verified = verifiedValue
        } else {
            verified = false
        }
    }
    
    var hasPhotos: Bool {
        get {
            return photos!.count > 0
        }
    }
    
    var thumbnailImage: UIImage? {
        get {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                return photo.image
            }
            return nil
        }
        set {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                photo.image = newValue!
            }
        }
    }
    
    var thumbnailPath: String? {
        get {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                return photo.documentPath
            }
            return nil
        }
        set {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                photo.documentPath = newValue!
                //photos[0].documentPath = newValue!
            }
        }
    }
    
    var thumbnailUrl: String? {
        get {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                return photo.getUrl(Photo.size.small)
            }
            return nil
        }
    }
    
    func getThumbnailUrl(size: String) -> String? {
        if (hasPhotos) {
            let photo = photos!.objectAtIndex(0) as! Photo
            return photo.getUrl(size)
        }
        return nil
    }
    
    var thumbnailPhoto: Photo? {
        get {
            if (hasPhotos) {
                let photo = photos!.objectAtIndex(0) as! Photo
                return photo
            }
            return nil
        }
        set {
            var photoArray = photos?.array as! [Photo]
            photoArray.insert(newValue!, atIndex: 0)
            photos = NSOrderedSet(array: photoArray)
        }
    }
}