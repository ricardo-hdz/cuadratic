//
//  FavoritesViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoritesTable: UITableView!
    
    var favorites = [FavoriteVenue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTable.delegate = self
        favoritesTable.dataSource = self


        dispatch_async(dispatch_get_main_queue(), {
            self.favoritesTable.reloadData()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        FavoritesHelper.getInstance().loadData()
        favorites = FavoritesHelper.getInstance().getFavorites()
        print("viewWillAppear")
        favoritesTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("Loading cells")
        let favorite = favorites[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("favoriteCell") as! ResultCell
        cell.title.text = favorite.name
        cell.location.text = favorite.location
        cell.entityType.text = favorite.category
        cell.thumbnail.image = CacheHelper.getInstance().getImage(favorite.thumbnail)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Returning count")
        return favorites.count
    }
    
}