//
//  FavoritesHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/26/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class FavoritesHelper {
    
    class func getInstance() -> FavoritesHelper {
        struct Singleton {
            static var instance = FavoritesHelper()
        }
        return Singleton.instance
    }
    
    func getFavorites() -> [Venue] {
        let user = UserHelper.getInstance().getCurrentUser()
        return user!.favorites.array as! [Venue]
    }
    
    func getFavoriteIds() -> [String] {
        let favorites = getFavorites()
        var ids = [String]()
        for favorite in favorites {
            ids.append(favorite.id)
        }
        return ids
    }
    
    func getFavoritesDictionary() -> [String:Venue] {
        let favorites:[Venue] = getFavorites()
        var favoritesDictionary = [String:Venue]()
        for favorite in favorites {
            favoritesDictionary[favorite.id] = favorite
        }
        return favoritesDictionary
    }
    
    func getFavorite(venueId: String) -> Venue? {
        let dictionary = getFavoritesDictionary()
        if let venue = dictionary[venueId] {
            return venue
        } else {
            return nil
        }
    }
    
    
}