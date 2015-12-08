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
    
    let locationManager = CLLocationManager()
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
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
        setupAutocompleteController()
        
        //searchVenues()
        
        resultsTableDefaultConstraint = NSLayoutConstraint(item: self.resultsTable, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: CGFloat(ViewConstants.searchBarHeight * 2 - ViewConstants.tableSectionHeight))
        
        resultsTableUpConstraint = NSLayoutConstraint(item: self.resultsTable, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: CGFloat(ViewConstants.searchBarHeight * 1 - ViewConstants.tableSectionHeight))
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestLocation()
    }
    
    override func getVenuesTable() -> UITableView {
        return self.resultsTable
    }
    
    func getLocationForQuery() -> [String:AnyObject] {
        var customLocation = searchLocationController?.searchBar.text
        customLocation = "Seattle"
        if (customLocation != "Near Me" && !customLocation!.isEmpty) {
            return [
                "near": customLocation!
            ]
        } else {
            if (location == nil) {
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
            self.view.addConstraint(self.resultsTableDefaultConstraint!)
            self.resultsTable.hidden = false
            self.resultsTable.reloadData()
        })
    }
    
    
    // Search Bar - Delegate
    
    func searchVenues() {
        venues = [Venue]()
        favoriteIds = FavoritesHelper.getInstance().getFavoriteIds()
        searchIndicator.startAnimating()
        var params = getLocationForQuery()
        let query = searchVenueController?.searchBar.text
        params["query"] = query
        
        SearchHelper.searchVenues(params) { venues, error in
            if let error = error {
                // TODO: display error in UI
                print(error)
                self.searchIndicator.stopAnimating()
            } else {
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
            self.searchVenueController?.searchBar.text = venueText
            self.searchLocationController?.searchBar.text = locationText
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