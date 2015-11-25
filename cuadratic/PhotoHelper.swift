//
//  PhotoHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/25/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import UIKit
class PhotoHelper: NSObject {
    
    class func getImage(url: String, callback: (image: UIImage?, error: NSError?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        let _ = requestHelper.dataRequest(url) {data, error in
            if let error = error {
                print("Error while requesting image at URL: \(url)")
                callback(image: nil, error: error)
            } else {
                let image = UIImage(data: data!)
                callback(image: image, error: nil)
            }
        }
    }
    
}