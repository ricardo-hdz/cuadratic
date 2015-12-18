//
//  ManagedVenuesViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/5/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
class ManagedVenuesViewController: VenueListViewController {
    var managedVenues = [Venue]()
    
    @IBOutlet var managedTable: UITableView!
    
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var managedVenuesLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        managedTable.delegate = self
        managedTable.dataSource = self
        
        getManagedVenues()
    }
    
    func refreshVenues() {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchIndicator.stopAnimating()
            self.managedTable.hidden = false
            self.managedTable.reloadData()
        })
    }
    
    override func getVenuesTable() -> UITableView {
        return self.managedTable
    }
    
    func getManagedVenues() {
        SearchHelper.getManagedVenues() { venues, error in
            if let _ = error {
                dispatch_async(dispatch_get_main_queue(), {
                    self.searchIndicator.stopAnimating()
                    self.managedTable.hidden = true
                    self.managedVenuesLabel.text = "Error while retrieving managed venues.\nPlease try again."
                    self.managedVenuesLabel.hidden = false
                })
            } else {
                if (venues?.count > 0) {
                    self.venues = venues!
                    print("Reloading data: \(venues?.count)")
                    self.refreshVenues()
                } else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.searchIndicator.stopAnimating()
                        self.managedTable.hidden = true
                        self.managedVenuesLabel.text = "You don't have any managed venues."
                        self.managedVenuesLabel.hidden = false
                    })
                }
            }
        }
    }
}