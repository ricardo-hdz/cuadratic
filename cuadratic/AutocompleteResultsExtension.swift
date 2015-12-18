//
//  AutocompleteResultsExtension.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/8/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

extension SearchViewController: GMSAutocompleteResultsViewControllerDelegate, UISearchControllerDelegate {
    
    func setupAutocompleteController() {
        resultsVenueViewController = GMSAutocompleteResultsViewController()
        resultsVenueViewController?.delegate = self
        
        resultsLocationViewController = GMSAutocompleteResultsViewController()
        resultsLocationViewController?.delegate = self
        
        searchLocationController = UISearchController(searchResultsController: resultsLocationViewController)
        searchLocationController?.delegate = self
        searchLocationController?.searchResultsUpdater = resultsLocationViewController
        searchLocationController?.obscuresBackgroundDuringPresentation = false
        searchLocationController?.dimsBackgroundDuringPresentation = false
        searchLocationController?.searchBar.delegate = self
        searchLocationController?.searchBar.placeholder = "Search Location"
        
        searchLocationView = UIView(frame: CGRectMake(0, 65.0, self.view.frame.size.width, 44.0))
        searchLocationView!.addSubview((searchLocationController?.searchBar)!)
        self.view.addSubview(searchLocationView!)
        searchLocationController?.searchBar.sizeToFit()
        searchLocationController?.hidesNavigationBarDuringPresentation = false
        
        searchVenueController = UISearchController(searchResultsController: resultsVenueViewController)
        searchVenueController?.delegate = self
        searchVenueController?.searchResultsUpdater = resultsVenueViewController
        searchVenueController?.obscuresBackgroundDuringPresentation = true
        searchVenueController?.dimsBackgroundDuringPresentation = true
        searchVenueController?.searchBar.delegate = self
        searchVenueController?.searchBar.placeholder = "Search Venues"
        
        searchVenueView = UIView(frame: CGRectMake(0, 65.0, self.view.frame.size.width, CGFloat(ViewConstants.searchBarHeight)))
        searchVenueView!.addSubview((searchVenueController?.searchBar)!)
        self.view.addSubview(searchVenueView!)
        searchVenueController?.searchBar.sizeToFit()
        searchVenueController?.hidesNavigationBarDuringPresentation = false
        
        self.definesPresentationContext = true
    }

    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didAutocompleteWithPlace place: GMSPlace!) {
        activeSearchController?.searchBar.text = place.name
        searchVenues()
        updateSearchControllers()
    }
    
    func resultsController(resultsController: GMSAutocompleteResultsViewController!, didFailAutocompleteWithError error: NSError!) {
        print("Error while autocompleting: \(error.localizedDescription)")
    }
    
    func willPresentSearchController(searchController: UISearchController) {
        activeSearchController = searchController
        if searchController == self.searchVenueController {
            if !locationActivated {
                displaySearchLocationBar()
                locationActivated = true
            }
        } else {
            setFocusSearchLocationBar()
        }
    }
}