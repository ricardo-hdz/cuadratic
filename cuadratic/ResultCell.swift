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
        if (!venue.isFavorite) {
            let dictionary:[String:AnyObject] = [
                "id": venue.id,
                "name": venue.name,
                "location": venue.location.fullLocationString,
                "category": venue.category.name,
                "thumbnail": (venue.thumbnailPhoto?.id)!
            ]
            
            let _ = FavoriteVenue(dictionary: dictionary, context: CoreDataHelper.getInstance().sharedContext)
            CoreDataStackManager.sharedInstance().saveContext()
            venue.isFavorite = true
            dispatch_async(dispatch_get_main_queue(), {
                print("Saving fav")
                self.favoriteButton.setTitle("Favorite", forState: UIControlState.Normal)
                self.reloadInputViews()
            })
        } else {
            let favorite = FavoritesHelper.getInstance().getFavorite(venue.id)
            CoreDataStackManager.sharedInstance().managedObjectContext.deleteObject(favorite!)
            CoreDataStackManager.sharedInstance().saveContext()
            venue.isFavorite = false
            dispatch_async(dispatch_get_main_queue(), {
                print("Deleteing fav")
                self.favoriteButton.setTitle("Save Favorite", forState: UIControlState.Normal)
                self.reloadInputViews()
            })
        }
    }
}