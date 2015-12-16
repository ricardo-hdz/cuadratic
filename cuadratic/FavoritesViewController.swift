//
//  FavoritesViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoritesTable: UITableView!
    
    var favorites = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self

        dispatch_async(dispatch_get_main_queue(), {
            self.favoritesTable.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        favorites = FavoritesHelper.getInstance().getFavorites()

        favoritesTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let favorite = favorites[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell") as! ResultCell
        cell.title.text = favorite.name
        
        if let category = favorite.category {
            cell.entityType.text = "\(category.name) - \(favorite.location?.shortLocationString)"
        }
        cell.verified.text = favorite.verified ? "Verified Venue" : "Unverified Venue"

        if let thumbnail = favorite.thumbnailImage {
            cell.thumbnail.image = thumbnail
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let venue = favorites[indexPath.row]
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("venueDetailController") as! VenueDetailViewController
        controller.venue = venue
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}