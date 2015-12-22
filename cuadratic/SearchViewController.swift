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
import CoreData
import GoogleMaps

class SearchViewController:
    VenueListViewController
{
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var searchPlacesLabel: UILabel!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var location: CLLocationCoordinate2D?
    
    var resultsVenueViewController: GMSAutocompleteResultsViewController?
    var resultsLocationViewController: GMSAutocompleteResultsViewController?
    var searchVenueController: UISearchController?
    var searchLocationController: UISearchController?
    
    var searchLocationView: UIView?
    var searchVenueView: UIView?
    var activeSearchController: UISearchController?
    var locationActivated: Bool = false
    var locationFirstResponder: Bool = false
    
    
    var resultsTableDefaultConstraint: NSLayoutConstraint?
    var resultsTableUpConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        if !isLocationServicesDenied() {
            if !isLocationServicesEnabled() {
                locationManager.requestWhenInUseAuthorization()
                locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
                locationManager.distanceFilter = kCLDistanceFilterNone
            }
        }
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        setupAutocompleteController()
        
        resultsTableDefaultConstraint = NSLayoutConstraint(item: self.resultsTable, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: CGFloat(ViewConstants.searchBarHeight * 2 - ViewConstants.tableSectionHeight))
        
        resultsTableUpConstraint = NSLayoutConstraint(item: self.resultsTable, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: CGFloat(ViewConstants.searchBarHeight * 1 - ViewConstants.tableSectionHeight))
    }
    
    override func getVenuesTable() -> UITableView {
        return self.resultsTable
    }
    
    func getLocationForQuery() -> [String:AnyObject]? {
        let customLocation = searchLocationController?.searchBar.text
        if (customLocation != "Near Me" && !customLocation!.isEmpty) {
            return [
                "near": customLocation!
            ]
        } else {
            if (location == nil) {
                // Check if location services is enabled
                if isLocationServicesDenied() {
                    BaseHelper.sendNotification(self, body: "Current location can not be determined as location services are not enabled on this device. Please enable them in Settings or specify a custom location.")
                } else {
                    BaseHelper.sendNotification(self, body: "Oops! We can't determine your location at this time. Please specifiy a location in the location bar.")
                }
                return nil
            } else {
                return [
                    "ll": "\(location!.latitude),\(location!.longitude)"
                ]
            }
        }
    }
    
    func refreshVenues() {
        self.searchIndicator.stopAnimating()
        self.view.addConstraint(self.resultsTableDefaultConstraint!)
        self.resultsTable.hidden = false

        self.resultsTable.reloadData()
    }
    
    
    // Search Bar - Delegate
    
    func searchVenues() {
        venues = [Venue]()
        favoriteIds = FavoritesHelper.getInstance().getFavoriteIds()
        var params = getLocationForQuery()
        let query = searchVenueController?.searchBar.text
        if params != nil {
            params!["query"] = query
            searchIndicator.startAnimating()
            
            SearchHelper.searchVenues(params!) { venues, error in
                if let error = error {
                    self.resultsTable.hidden = true
                    self.searchPlacesLabel.text = error
                    self.searchIndicator.stopAnimating()
                    self.searchPlacesLabel.hidden = false
                } else {
                    
                    if (venues?.count > 0) {
                        self.venues = venues!
                        self.refreshVenues()
                    } else {
                        self.searchIndicator.stopAnimating()
                        self.resultsTable.hidden = true
                        self.searchPlacesLabel.text = "No results found for \(query!)"
                        self.searchPlacesLabel.hidden = false
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("headerCell") as! ResultHeaderCellTableViewCell
        return header
    }
    
    func updateSearchControllers() {
        let venueText = searchVenueController?.searchBar.text
        let locationText = searchLocationController?.searchBar.text
        
        searchVenueController?.active = false
        searchLocationController?.active = false
        
        dispatch_async(dispatch_get_main_queue(), {
            self.searchVenueController?.searchBar.text = venueText!
            self.searchLocationController?.searchBar.text = locationText!
        })
    }
    
    func displaySearchLocationBar() {
        UIView.animateWithDuration(0.3, animations: {
            self.searchLocationView?.center.y += CGFloat(ViewConstants.searchBarHeight)
            
        })
    }
    
    func setFocusSearchLocationBar() {
        self.view.removeConstraint(self.resultsTableDefaultConstraint!)
        self.view.addConstraint(self.resultsTableUpConstraint!)
        
        UIView.animateWithDuration(0.3, animations: {
            self.searchLocationView?.center.y -= CGFloat(ViewConstants.searchBarHeight)
        })
        
    }
    
    func unsetFocusSearchLocationBar() {
        self.view.removeConstraint(self.resultsTableUpConstraint!)
        self.view.addConstraint(self.resultsTableDefaultConstraint!)
        
        UIView.animateWithDuration(0.3, animations: {
            self.searchLocationView?.center.y += CGFloat(ViewConstants.searchBarHeight)
        })
        
    }

    
    func hideSearchLocationBar() {
        UIView.animateWithDuration(0.3, animations: {
            self.searchLocationView?.center.y -= CGFloat(ViewConstants.searchBarHeight)
        })
    }
}