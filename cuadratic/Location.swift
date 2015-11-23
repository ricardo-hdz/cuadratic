//
//  Location.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class Location {
    var address: String
    var lat: Double
    var lon: Double
    //var distance: Int
    var city: String
    var state: String
    var country: String
    var formattedAddress: [String]
    
    init(dictionary: [String: AnyObject]) {
        address = (dictionary["address"] as? String) ?? "NA"
        lat = (dictionary["lat"] as? Double) ?? 0.0
        lon = (dictionary["lng"] as? Double) ?? 0.0
        //distance = dictionary["distance"] as! Int
        city = (dictionary["city"] as? String) ?? "NA"
        state = (dictionary["state"] as? String) ?? "NA"
        country = (dictionary["country"] as? String) ?? "NA"
        formattedAddress = (dictionary["formattedAddress"] as? [String]) ?? ["NA"]
    }
    
    var fullLocationString: String {
        get {
            var locationString: String = ""
            for address in formattedAddress {
                locationString += address
            }
            return locationString
        }
    }

}