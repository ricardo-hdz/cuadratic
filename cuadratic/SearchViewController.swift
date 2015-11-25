//
//  SearchViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchPlacesLabel: UILabel!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var venues = [Venue]()
    var location: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates & data sources
        searchBar.delegate = self
        locationBar.delegate = self
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        // Request location auth
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.startUpdatingLocation()
            locationManager.requestLocation()
            print("Locating")
        } else {
            print("Location disabled")
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        
        let cell = resultsTable.dequeueReusableCellWithIdentifier("resultCell") as! ResultCell
        cell.title.text = venue.name
        cell.location.text = venue.location.fullLocationString
        cell.entityType.text = venue.category.name
        if let thumbnail = venue.thumbnail {
            cell.thumbnail.image = thumbnail
            cell.imageLoadingIndicator.stopAnimating()
        } else {
            cell.imageLoadingIndicator.startAnimating()
            getThumbnailForVenue(indexPath)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func getThumbnailForVenue(index: NSIndexPath) {
        let venue = venues[index.row]
        
        if (!venue.id.isEmpty) {
            let params: [String: String] = [
                "limit": "1"
            ]
            SearchHelper.getVenuePhotos(venue.id, params: params) { photos, error in
                if let error = error {
                    // ignore and display placelholder
                    print("Error getVenuePhotos: \(error)")
                } else {
                    // request photo
                    self.venues[index.row].photos = photos
                    self.loadThumbnailForVenue(index)
                }
                // save in context
            }
        }
        
    }
    
    func loadThumbnailForVenue(index: NSIndexPath) {
        let venue = self.venues[index.row]
        if (venue.photos?.count > 0) {
            let url = venue.photos![0].getUrl(Photo.size.small)
            if !url.isEmpty {
                PhotoHelper.getImage(url) { image, error in
                    if let error = error {
                        print("Unable to get image for URL: \(url). Error: \(error)")
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.venues[index.row].thumbnail = image!
                            self.resultsTable.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
                        })
                    }
                }
            }
        }
    }
    
    func getLocationForQuery() -> [String:AnyObject] {
        let customLocation = locationBar.text!
        if (customLocation != "Near Me" && !customLocation.isEmpty) {
            return [
                "near": customLocation
            ]
        } else {
             return [
                "ll": "\(location.latitude),\(location.longitude)"
            ]
        }
    }
    
    func refreshVenues() {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchIndicator.stopAnimating()
            self.resultsTable.hidden = false
            self.resultsTable.reloadData()
        })
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = manager.location?.coordinate
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location: \(error.localizedDescription)")
    }
    
    
    // Search Bar - Delegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if (!searchBar.text!.isEmpty) {
            venues = [Venue]()
            searchIndicator.startAnimating()
            var params = getLocationForQuery()
            let query = self.searchBar.text!
            params["query"] = query
            
            searchBar.endEditing(true)
            
            SearchHelper.searchVenues(params) { venues, error in
                if let error = error {
                    // display error in UI
                    print(error)
                    self.searchIndicator.stopAnimating()
                } else {
                    print("Venues count \(venues?.count)")
                    if (venues?.count > 0) {
                        self.venues = venues!
                        self.refreshVenues()
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.searchIndicator.stopAnimating()
                            self.resultsTable.hidden = true
                            self.searchPlacesLabel.text = "No results found for \(query)"
                            self.searchPlacesLabel.hidden = false
                        })
                        
                    }
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchPlacesLabel.hidden = true
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchPlacesLabel.hidden = true
    }
    

}

extension SearchViewController: CustomDebugStringConvertible {
    override var description: String {
        return "Venues contain \(venues.count)"
    }
    
    override var debugDescription: String {
        var index = 0;
        var debugString = "Venues contain \(venues.count)"
        for venue in venues {
            debugString = debugString + "Venue\(index): " + venue.name
            index += 1
        }
        return debugString
    }
}