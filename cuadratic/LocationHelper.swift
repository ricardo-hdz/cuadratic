//
//  LocationHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/16/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import MapKit

class LocationHelper {
    class func searchGeocodeByString(location: String, callback: (placemark: CLPlacemark?, error: String?) -> Void) {
        CLGeocoder().geocodeAddressString(location) { placemarks, error in
            if let error = error {
                callback(placemark: nil, error: error.localizedDescription)
            } else {
                if placemarks?.count > 0 {
                    if placemarks![0].location != nil {
                        callback(placemark: placemarks![0], error: nil)
                    } else {
                        callback(placemark: nil, error: "No location found for \(location)")
                    }
                } else {
                    callback(placemark: nil, error: "Unable to geocode this location.")
                }
            }
        }
    }
}