//
//  SearchHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData

class SearchHelper {
    
    class func searchVenues(params: [String:AnyObject], callback: (results: [Venue]?, error: String?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        let endpoint = NetworkRequestHelper.Constants.API.FSQ_ENDPOINT + NetworkRequestHelper.Constants.API.VENUES.SEARCH_VENUE
        
        requestHelper.serviceRequestWithToken(endpoint, requestMethod: "GET", headers: [:], params: params, jsonBody: nil, postProcessor: nil) {
            result, error in
            if let error = error {
                callback(results: nil, error: error.localizedDescription)
            } else {
                if let response = result!.valueForKey("response") as? [String: AnyObject] {
                    if let venues = response["venues"] as? [[String:AnyObject]] {
                        let venueResults = SearchHelper.parseVenuesFromResponse(venues)
                        callback(results: venueResults, error: nil)
                    } else {
                        callback(results: nil, error: "No venues found in response")
                    }
                    
                } else {
                    callback(results: nil, error: "No results found for \(params["query"]!)")
                }
            }
        }
    }
    
    class func parseVenuesFromResponse(venues: [[String:AnyObject]]) -> [Venue] {
        var venueResults = [Venue]()
        for var venueData in venues {
            let temporaryContext = CoreDataHelper.getInstance().temporaryContext
            let venue = Venue(dictionary: venueData, context: temporaryContext)
            let locationData = venueData["location"] as! [String: AnyObject]
            let location = Location(dictionary: locationData, context: temporaryContext)
            let categoriesData = venueData["categories"] as! [[String: AnyObject]]
            let category = Category(dictionary: categoriesData, context: temporaryContext)
            venue.category = category
            venue.location = location
            
            venueResults.append(venue)
        }
        return venueResults
    }
    
    class func getManagedVenues(callback: (venues: [Venue]?, error: String?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        let endpoint = NetworkRequestHelper.getInstance().getFoursquareEndpoint() + NetworkRequestHelper.Constants.API.VENUES.SEARCH_MANAGED
        
        requestHelper.serviceRequestWithToken(endpoint, requestMethod: "GET", headers: [:], params: [:], jsonBody: nil, postProcessor: nil) { result, error in
            if let error = error {
                callback(venues: nil, error: error.localizedDescription)
            } else {
                if let response = result!.valueForKey("response") as? NSDictionary {
                    if let venues = response.valueForKey("venues") as? NSDictionary {
                        if let items = venues.valueForKey("items") as? [[String:AnyObject]] {
                            let venueResults = SearchHelper.parseVenuesFromResponse(items)
                            callback(venues: venueResults, error: nil)
                        } else {
                            callback(venues: nil, error: "No items in venues")
                        }
                    } else {
                        callback(venues: nil, error: "No venues found in response")
                    }
                } else {
                    callback(venues: nil, error: "This user does not have any managed venues")
                }
            }
        }
    }
    
    class func getVenuePhotos(venueId: String, params: [String: String], callback: (photos: [Photo]?, error: String?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        var endpoint = NetworkRequestHelper.Constants.API.FSQ_ENDPOINT + NetworkRequestHelper.Constants.API.VENUES.SEARCH_VENUE_PHOTOS
        
        endpoint = NetworkRequestHelper.getInstance().replaceParamsInUrl(endpoint, paramId: "VENUE_ID", paramValue: venueId)!
        
        requestHelper.serviceRequestWithToken(endpoint, requestMethod: "GET", headers: [:], params: params, jsonBody: nil, postProcessor: nil) { result, error in
            if let error = error {
                callback(photos: nil, error: error.localizedDescription)
            } else {
                if let response = result!.valueForKey("response") as? [String: AnyObject] {
                    if let photos = response["photos"] as? [String:AnyObject] {
                        if let items = photos["items"] as? [[String:AnyObject]] {
                            let temporaryContext = CoreDataHelper.getInstance().temporaryContext
                            var photoResults = [Photo]()
                            for item in items {
                                let photo = Photo(dictionary: item, context: temporaryContext)
                                photoResults.append(photo)
                            }
                            callback(photos: photoResults, error: nil)
                        } else {
                            callback(photos: nil, error: "No photos found for venue")
                        }
                    } else {
                        callback(photos: nil, error: "Error while requesting photos for venue. No photos found in response")
                    }
                }
            }
        
        }
    }

}