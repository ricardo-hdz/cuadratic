//
//  ResultCell.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ResultCell: UITableViewCell {
    var venue: Venue!
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var entityType: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    @IBAction func updateFavorite(sender: AnyObject) {
        if venue.favorite == nil {
            print("Favorite is nill")
            let sharedContext = CoreDataHelper.getInstance().sharedContext
            
            let venueData = BaseHelper.getDictionaryForManagedObject(venue)
            let venueContext = Venue(dictionary: venueData, context: sharedContext)
            
            let locationData = BaseHelper.getDictionaryForManagedObject(venue.location!)
            let locationContext = Location(dictionary: locationData, context: sharedContext)
            
            let categoryData = BaseHelper.getDictionaryForManagedObject(venue.category!)
            print("Category data: \(categoryData)")
            let category = Category(dictionary: [categoryData], context: sharedContext)
            
            venueContext.location = locationContext
            venueContext.category = category
            
            let photoData = BaseHelper.getDictionaryForManagedObject(venue.thumbnailPhoto!)
            let photo = Photo(dictionary: photoData, context: sharedContext)
            venueContext.photos = NSOrderedSet(array: [photo])

            if let user = UserHelper.getInstance().getCurrentUser() {
                venueContext.favorite = user
            }
            
            venue = venueContext
            
            CoreDataStackManager.sharedInstance().saveContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.favoriteButton.setTitle("Remove Favorite", forState: UIControlState.Normal)
                self.reloadInputViews()
            })
        } else {
            venue.favorite = nil
            let sharedContext = CoreDataHelper.getInstance().sharedContext
            sharedContext.refreshObject(venue, mergeChanges: true)
            CoreDataStackManager.sharedInstance().saveContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                self.favoriteButton.setTitle("Save Favorite", forState: UIControlState.Normal)
                self.reloadInputViews()
            })
        }
    }
}