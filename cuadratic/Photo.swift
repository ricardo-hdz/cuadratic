//
//  Photo.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/25/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
class Photo: NSObject {
    var id: String!
    var prefix: String!
    var suffix: String!
    var documentPath: String
    
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
        documentPath = ""
    }
    
    func getUrl(size: String) -> String {
        return prefix + size + suffix
    }
    
    var image: UIImage? {
        get {
            if !documentPath.isEmpty {
                return CacheHelper.getInstance().getImage(self.id)
            }
            return nil
        }
        set {
            documentPath = CacheHelper.getInstance().pathForObject(self.id)
            CacheHelper.getInstance().saveImage(newValue!, id: self.id)
        }
    }
}