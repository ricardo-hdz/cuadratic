//
//  VenueDetailViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/28/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift
import MapKit

class VenueDetailViewController: UIViewController, UINavigationControllerDelegate {
    var venue: Venue!
    var stats: Stats!
    
    @IBOutlet weak var venueThumbnail: UIImageView!
    
    @IBOutlet weak var venueTitle: UILabel!
  
    @IBOutlet weak var totalCheckins: UILabel!
    @IBOutlet weak var twitterCheckins: UILabel!
    @IBOutlet weak var facebookCheckins: UILabel!
    @IBOutlet weak var femaleCheckins: UILabel!
    @IBOutlet weak var maleCheckins: UILabel!
    
    // icons
    @IBOutlet weak var totalCheckinsIcon: UILabel!
    @IBOutlet weak var facebookIcon: UILabel!
    @IBOutlet weak var twitterIcon: UILabel!
    @IBOutlet weak var femaleIcon: UILabel!
    @IBOutlet weak var maleIcon: UILabel!
    
    @IBOutlet weak var viewAgeBreakdown: UIButton!
    @IBOutlet weak var viewHourBreakdown: UIButton!
    
    @IBOutlet weak var ageBreakdownLabel: UILabel!
    @IBOutlet weak var hourBreakdownLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        venueThumbnail.clipsToBounds = true
        
        setVenueHeader()
        loadThumbnailForVenue()
        setIcons()
        getVenueStats()
        searchVenueLocation()
    }
    
    func setIcons() {
        totalCheckinsIcon.font = UIFont.fontAwesomeOfSize(14.0)
        totalCheckinsIcon.text = String.fontAwesomeIconWithCode("fa-check-circle-o")
        
        facebookIcon.font = UIFont.fontAwesomeOfSize(14.0)
        facebookIcon.text = String.fontAwesomeIconWithCode("fa-facebook")
        
        twitterIcon.font = UIFont.fontAwesomeOfSize(14.0)
        twitterIcon.text = String.fontAwesomeIconWithCode("fa-twitter")
        
        femaleIcon.font = UIFont.fontAwesomeOfSize(14.0)
        femaleIcon.text = String.fontAwesomeIconWithCode("fa-female")
        
        maleIcon.font = UIFont.fontAwesomeOfSize(14.0)
        maleIcon.text = String.fontAwesomeIconWithCode("fa-male")
    }
    
    @IBAction func viewAgeBreakdown(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ageBreakdownViewController") as! AgeBreakdownViewController
        controller.stats = self.stats
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func viewHourBreakdown(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("hourBreakdownViewController") as! HourBreakdownViewController
        controller.stats = self.stats
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func loadThumbnailForVenue() {
        if (venue.hasPhotos) {
            let url = venue.getThumbnailUrl(Photo.size.medium)
            if url != nil {
                PhotoHelper.getImage(url!) { image, error in
                    if let error = error {
                        print("Unable to get image for URL: \(url). Error: \(error)")
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.venueThumbnail.image = image!
                        })
                    }
                }
            }
        }
    }

    
    func setVenueHeader() {
        venueTitle.text = venue.name
    }
    
    func getVenueStats() {
        StatsHelper.getVenueStats(venue.id) {stats, error in
            if let _ = error {
                BaseHelper.sendNotification(self, body: "Stats for this venue are currently unavailable. Please try later.")
            } else {
                if let stats = stats {
                    self.stats = stats
                    dispatch_async(dispatch_get_main_queue(), {
                        self.displayVenueStats(stats)
                    })
                }
            }
        }
    }
    
    func displayVenueStats(stats: Stats) {
        totalCheckins.text = "\(stats.totalCheckins)"
        twitterCheckins.text = "\(stats.twitterCheckins)"
        facebookCheckins.text = "\(stats.facebookCheckins)"
        femaleCheckins.text = "\(stats.femaleCheckins)"
        maleCheckins.text = "\(stats.maleCheckins)"
        
        let primeSegment = stats.getMaxIdFromBreakdown(stats.ageBreakdown, fieldName: "age")
        ageBreakdownLabel.text = ageBreakdownLabel.text!.stringByReplacingOccurrencesOfString("{age}", withString: primeSegment)
        
        let primeHour = stats.getMaxIdFromBreakdown(stats.hourBreakdown, fieldName: "hour")
        let formattedHour = stats.getFormattedHour(primeHour)
        hourBreakdownLabel.text = hourBreakdownLabel.text!.stringByReplacingOccurrencesOfString("{hour}", withString: formattedHour)
    }

}