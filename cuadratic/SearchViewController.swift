//
//  SearchViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    
    var venues = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegates & data sources
        searchBar.delegate = self
        locationBar.delegate = self
        resultsTable.delegate = self
        resultsTable.dataSource = self
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let venue = venues[indexPath.row]
        
        let cell = resultsTable.dequeueReusableCellWithIdentifier("resultCell") as! ResultCell
        cell.title.text = venue.name
        cell.location.text = venue.location.fullLocationString
        cell.entityType.text = venue.category.name
        
        let thumbnail = UIImage(named: "placeholder")
        cell.entityThumbnail = UIImageView(image: thumbnail)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // Search code
        print("Searching")
        let query = searchBar.text
        SearchHelper.searchVenues(query!) { venues, error in
            if let error = error {
                // display error in UI
                print(error)
            } else {
                self.venues = venues!
                print(self)
                debugPrint(self)
                print("one")
                self.refreshVenues()
            }
        }
    }
    
    func refreshVenues() {
        dispatch_async(dispatch_get_main_queue(), {
            self.resultsTable.reloadData()
        })
        
    }

}

extension SearchViewController: CustomDebugStringConvertible {
    override var description: String {
        return "Venues contain \(venues.count)"
    }
    
    override var debugDescription: String {
        var index = 0;
        var debugString = "Venues contain \(venues.count)"
        for venue in venues {
            debugString = debugString + "Venue\(index): " + venue.name
            index += 1
        }
        return debugString
    }
}