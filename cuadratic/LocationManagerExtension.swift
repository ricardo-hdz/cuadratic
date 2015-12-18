//
//  LocationManagerExtension.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/8/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreLocation

extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            print("Location manager has locations")
            self.location = locations[0].coordinate
        } else {
            print("Location manager does not have locations")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        BaseHelper.sendNotification(self, body: "Oops! We couldn't find your current location. Please specify a location for your searches ")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if isLocationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse
    }
    
    func isLocationServicesDenied() -> Bool {
        return CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Restricted
    }
}