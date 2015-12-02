//
//  Venue.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
class Venue: NSObject {
    var id: String
    var name: String
    var location: Location
    var category: Category
    var photos: [Photo]?
    var isFavorite: Bool

    init(dictionary: [String: AnyObject]) {
        id = (dictionary["id"] as? String)!
        name = (dictionary["name"] as? String)!
        category = Category(dictionary: dictionary["categories"] as! [[String:AnyObject]])
        location = (dictionary["location"] as? Location)!
        isFavorite = false
    }
    
    var hasPhotos: Bool {
        get {
            return photos?.count > 0
        }
    }
    
    var thumbnailImage: UIImage? {
        get {
            if (hasPhotos) {
                return photos![0].image
            }
            return nil
        }
        set {
            if (hasPhotos) {
                photos![0].image = newValue!
            }
        }
    }
    
    var thumbnailPath: String? {
        get {
            if (hasPhotos) {
                return photos![0].documentPath
            }
            return nil
        }
        set {
            if (hasPhotos) {
                photos![0].documentPath = newValue!
            }
        }
    }
    
    var thumbnailUrl: String? {
        get {
            if (hasPhotos) {
                return photos![0].getUrl(Photo.size.small)
            }
            return nil
        }
    }
    
    var thumbnailPhoto: Photo? {
        get {
            if (hasPhotos) {
                return photos![0]
            }
            return nil
        }
    }
    
}