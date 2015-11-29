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

class SearchViewController: VenueListViewController, UISearchBarDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchPlacesLabel: UILabel!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates & data sources
        searchBar.delegate = self
        locationBar.delegate = self
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleDismissTap:")
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.delegate = self
        self.view.addGestureRecognizer(tapRecognizer)
        
        searchVenues()
    }
    
    override func viewWillAppear(animated: Bool) {

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()

    }
    
    // Tap Recognizer
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return searchBar.isFirstResponder() || locationBar.isFirstResponder()
    }
    
    func handleDismissTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func getVenuesTable() -> UITableView {
        return self.resultsTable
    }
    
    // Tap Cell
    
    
    func getLocationForQuery() -> [String:AnyObject] {
        let customLocation = locationBar.text!
        if (customLocation != "Near Me" && !customLocation.isEmpty) {
            return [
                "near": customLocation
            ]
        } else {
            if (location == nil) {
                print("Requesting locations as == nil")
                dispatch_async(dispatch_get_main_queue(), {
                    self.locationManager.requestLocation()
                })
            }
            return [
                "ll": "\(location!.latitude),\(location!.longitude)"
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
        print("Updated location")
        self.location = manager.location?.coordinate
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location: \(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Statis changed")
        print("Status: \(status)")
        if (status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            // request location
            if (CLLocationManager.locationServicesEnabled()) {
                
                //locationManager.startUpdatingLocation()
                locationManager.requestLocation()
                print("Locating")
            } else {
                print("Location disabled")
            }
        }
    }
    
    
    // Search Bar - Delegate
    
    func searchVenues() {
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if (!searchBar.text!.isEmpty) {
            searchVenues()
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