//
//  MapExtension.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/16/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import MapKit

extension VenueDetailViewController: MKMapViewDelegate {    
    func searchVenueLocation() {
        LocationHelper.searchGeocodeByString((venue.location?.fullLocationString)!) { placemark, error in
            if let _ = error {
                BaseHelper.sendNotification(self, body: "Unable to locate venue in map. Please try again later.")
            } else {
                self.setPlacemarkInMap(placemark!)
                dispatch_async(dispatch_get_main_queue(), {
                    // display controls
                    //self.activityIndicator.stopAnimating()
                    //self.displayControlsMap()
                })
            }
        }
    }
    
    func setPlacemarkInMap(placemark: CLPlacemark) {
        let annotationPoint = MKPointAnnotation()
        annotationPoint.title = venue.name
        let locationCoord = CLLocationCoordinate2DMake(placemark.location!.coordinate.latitude, placemark.location!.coordinate.longitude)
        annotationPoint.coordinate = locationCoord
        
        let annotationView = MKAnnotationView(annotation: annotationPoint, reuseIdentifier: nil)

        let mapRegion = MKCoordinateRegionMakeWithDistance(locationCoord, 500, 500)
        let adjustedRegion = self.mapView.regionThatFits(mapRegion)
        mapView.setRegion(adjustedRegion, animated: false)
        mapView.addAnnotation(annotationView.annotation!)
    }
    
        
    
    
}