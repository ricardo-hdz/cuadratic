//
//  FavoritesHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class FavoritesHelper {
    
    var favorites = [FavoriteVenue]()
    var favoritesDictionary = [String:FavoriteVenue]()
    var favoriteIds = [String]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        favorites = CoreDataHelper.getInstance().fetchData("FavoriteVenue") as! [FavoriteVenue]
        favoritesDictionary = getFavoritesDictionary()
        favoriteIds = getFavoriteIds()
    }
    
    class func getInstance() -> FavoritesHelper {
        struct Singleton {
            static var instance = FavoritesHelper()
        }
        return Singleton.instance
    }
    
    func getFavorites() -> [FavoriteVenue] {
        return favorites
    }
    
    func getFavoriteIds() -> [String] {
        var ids = [String]()
        for favorite in favorites {
            ids.append(favorite.id)
        }
        return ids
    }
    
    func getFavoritesDictionary() -> [String:FavoriteVenue] {
        let favorites:[FavoriteVenue] = getFavorites()
        var favoritesDictionary = [String:FavoriteVenue]()
        for favorite in favorites {
            favoritesDictionary[favorite.id] = favorite
        }
        return favoritesDictionary
    }
    
    func getFavorite(venueId: String) -> FavoriteVenue? {
        if let venue = favoritesDictionary[venueId] {
            return venue
        } else {
            return nil
        }
    }
    
    
}