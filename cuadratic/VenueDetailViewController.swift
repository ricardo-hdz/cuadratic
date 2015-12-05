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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        getVenueStats()
        setVenueHeader()
        
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
    }
    
    func getVenueStats() {
        StatsHelper.getVenueStats(venue.id) {stats, error in
            if let error = error {
                // TODO
                print("Error while requesting stats: \(error)")
            } else {
                if let stats = stats {
                    self.stats = stats
                    self.venue.stats = stats
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