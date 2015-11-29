//
//  VenueDetailViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/28/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
class VenueDetailViewController: UIViewController, UINavigationControllerDelegate {
    var venue: Venue!
    
    @IBOutlet weak var venueThumbnail: UIImageView!
    
    @IBOutlet weak var venueTitle: UILabel!
    
    @IBOutlet weak var venueCategory: UILabel!
    
    @IBOutlet weak var venueLocation: UILabel!
    @IBOutlet weak var totalCheckins: UILabel!
    @IBOutlet weak var twitterCheckins: UILabel!
    @IBOutlet weak var facebookCheckins: UILabel!
    @IBOutlet weak var femaleCheckins: UILabel!
    @IBOutlet weak var maleCheckins: UILabel!
    @IBOutlet weak var age1317: UILabel!
    @IBOutlet weak var age1824: UILabel!
    @IBOutlet weak var age2534: UILabel!
    @IBOutlet weak var age3544: UILabel!
    @IBOutlet weak var age4554: UILabel!
    @IBOutlet weak var age55: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getVenueStats()
        setVenueHeader()
    }
    
    func setNavigationBar() {
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.grayColor()
        navBar?.tintColor = UIColor.whiteColor()
    }
    
    func setVenueHeader() {
        venueThumbnail.image = venue.thumbnailImage!
        venueThumbnail.layer.cornerRadius = venueThumbnail.frame.size.width / 2
        venueThumbnail.clipsToBounds = true
        
        venueTitle.text = venue.name
        venueCategory.text = venue.category.name
        venueLocation.text = venue.location.fullLocationString
    }
    
    func getAgeLabels() -> [UILabel] {
        return [
            age1317, age1824, age2534, age3544, age4554, age55
        ]
    }
    
    func getVenueStats() {
        StatsHelper.getVenueStats(venue.id) {stats, error in
            if let error = error {
                print("Error while requesting stats: \(error)")
            } else {
                if let stats = stats {
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
        
        let ageLabels = getAgeLabels()
        for (var index = 0; index < ageLabels.count; index++) {
            
            let age = stats.ageBreakdown[index]
            print("Age: \(age)")
            ageLabels[index].text = "\(age.valueForKey("checkins")!)"
        }
        
    }

}