//
//  VenueListViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//


import UIKit
class VenueListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {    
    
    var venues = [Venue]()
    var favoriteIds = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell") as! ResultCell
        cell.title.text = venue.name
        cell.location.text = venue.location!.fullLocationString
        cell.entityType.text = venue.category!.name
        if venue.photos!.count > 0 {
            //let thumbnail = venue.photos[0].image
            let thumbnail = venue.thumbnailImage
            cell.thumbnail.image = thumbnail
            cell.imageLoadingIndicator.stopAnimating()
        } else {
            cell.imageLoadingIndicator.startAnimating()
            getThumbnailForVenue(indexPath)
        }
        
        if favoriteIds.contains(venue.id) {
            venue.favorite = UserHelper.getInstance().getTempUser()
            cell.favoriteButton.setTitle("Remove Favorite", forState: UIControlState.Normal)
        } else {
            cell.favoriteButton.setTitle("Favorite", forState: UIControlState.Normal)
        }
        
        cell.venue = venue
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as! ResultHeaderCellTableViewCell
        return header
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let venue = venues[indexPath.row]
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("venueDetailController") as! VenueDetailViewController
        controller.venue = venue
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getVenuesTable() -> UITableView {
        preconditionFailure("This method must be overriden")
    }
    
    func getThumbnailForVenue(index: NSIndexPath) {
        let venue = venues[index.row]
        
        if (!venue.id.isEmpty) {
            let params: [String: String] = [
                "limit": "1"
            ]
            SearchHelper.getVenuePhotos(venue.id, params: params) { photos, error in
                if let error = error {
                    // TODO ignore and display placelholder
                    print("Error getVenuePhotos: \(error)")
                } else {
                    self.venues[index.row].photos = NSOrderedSet(array: photos!)
                    self.loadThumbnailForVenue(index)
                }
            }
        }
        
    }
    
    func loadThumbnailForVenue(index: NSIndexPath) {
        let venue = self.venues[index.row]
        if (venue.hasPhotos) {
            let url = venue.thumbnailUrl
            if !url!.isEmpty {
                PhotoHelper.getImage(url!) { image, error in
                    if let error = error {
                        // TODO
                        print("Unable to get image for URL: \(url). Error: \(error)")
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            venue.thumbnailImage = image
                            self.getVenuesTable().reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
                        })
                    }
                }
            }
        }
    }

}