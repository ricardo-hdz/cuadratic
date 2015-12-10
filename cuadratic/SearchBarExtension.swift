//
//  SerachBarExtension.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/8/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
extension SearchViewController: UISearchBarDelegate {    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if searchBar == searchLocationController?.searchBar {
            unsetFocusSearchLocationBar()
        }
        if (!searchBar.text!.isEmpty) {
            searchPlacesLabel.hidden = true
            searchVenues()
        }
        updateSearchControllers()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchPlacesLabel.hidden = true
    }
}