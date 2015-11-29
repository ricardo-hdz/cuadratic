//
//  StatsHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/28/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class StatsHelper: NSObject {
    
    class func getVenueStats(venueId: String, callback: (stats: Stats?, error: String?) -> Void){
        let helper = NetworkRequestHelper.getInstance()
        var endpoint = helper.getFoursquareEndpoint() + NetworkRequestHelper.Constants.API.VENUES.SEARCH_VENUE_STATS
        endpoint = helper.replaceVenueInEndpoint(endpoint, venueId: venueId)
        
        helper.serviceRequestWithToken(endpoint, requestMethod: "GET", headers: [:], params: [:], jsonBody: nil, postProcessor: nil) { result, error in
            if let error = error {
                callback(stats: nil, error: error.localizedDescription)
            } else {
                if let response = result!.valueForKey("response") as? [String: AnyObject] {
                    if let stats = response["stats"] as? [String:AnyObject] {
                        let sharing = stats["sharing"] as? NSDictionary
                        let twitterCheckins = sharing?.valueForKey("twitter")
                        let facebookCheckins = sharing?.valueForKey("facebook")
                        
                        let genderBreakdown = stats["genderBreakdown"] as? NSDictionary
                        let maleCheckins = genderBreakdown?.valueForKey("male")
                        let femaleCheckins = genderBreakdown?.valueForKey("female")
                        
                        let dictionary: [String:AnyObject] = [
                            "totalCheckins": stats["totalCheckins"]!,
                            "twitterCheckins": twitterCheckins!,
                            "facebookCheckins": facebookCheckins!,
                            "maleCheckins": maleCheckins!,
                            "femaleCheckins": femaleCheckins!,
                            "ageBreakdown": stats["ageBreakdown"]!,
                            "hourBreakdown": stats["hourBreakdown"]!
                        ]
                        let stats = Stats(dictionary: dictionary)
                        callback(stats: stats, error: nil)
                    } else {
                        callback(stats: nil, error: "Error while requesting stats for venue. No stats found in response")
                    }
                } else {
                     callback(stats: nil, error: "Error while requesting stats for venue. No stats found in response")
                }
            }
        
        }
        
    }
}