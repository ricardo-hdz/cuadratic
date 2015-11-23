//
//  SearchHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class SearchHelper {
    
    class func searchVenues(query: String, callback: (results: [Venue]?, error: String?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        let endpoint = NetworkRequestHelper.Constants.API.FSQ_ENDPOINT + NetworkRequestHelper.Constants.API.VENUES.METHOD
        let params = [
            "query": query,
            "near": "Seattle"
        ]
        
        print("Query: \(endpoint)")
        
        requestHelper.serviceRequestWithToken(endpoint, requestMethod: "GET", headers: [:], params: params, jsonBody: nil, postProcessor: nil) {
            result, error in
            if let error = error {
                callback(results: nil, error: error.localizedDescription)
            } else {
                
                if let response = result!.valueForKey("response") as? [String: AnyObject] {

                    let venues = response["venues"] as? [[String:AnyObject]]
                    var venueResults = [Venue]()
                    for var venueData in venues! {
                        print(venueData)
                        // Location
                        let locationData = venueData["location"] as! [String: AnyObject]
                        let location = Location(dictionary: locationData)
                        venueData["location"] = location
                        
                        // Stats
                        let statsData = venueData["stats"] as! [String:AnyObject]
                        let stats = Stats(dictionary: statsData)
                        venueData["stats"] = stats
                        
                        let venue = Venue(dictionary: venueData)
                        venueResults.append(venue)
                    }
                    callback(results: venueResults, error: nil)
                } else {
                    callback(results: nil, error: "No results found for \(query)")
                }
            }
        }
    }

}