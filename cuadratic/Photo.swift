//
//  Photo.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/25/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
class Photo: NSObject {
    var id: String!
    var prefix: String!
    var suffix: String!
    
    struct size {
        static let thumbnail = "36x36"
        static let small = "100x100"
        static let medium = "300x500"
        static let large = "500x500"
    }
    
    init(dictionary: [String: AnyObject]) {
        id = dictionary["id"] as! String!
        prefix = dictionary["prefix"] as! String!
        suffix = dictionary["suffix"] as! String!
    }
    
    func getUrl(size: String) -> String {
        return prefix + size + suffix
    }
}