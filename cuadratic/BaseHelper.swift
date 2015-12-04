//
//  BaseHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/2/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import CoreData

class BaseHelper {
    
    class func getInstance() -> BaseHelper {
        struct Singleton {
            static var instance = BaseHelper()
        }
        return Singleton.instance
    }
    
    class func getDictionaryForManagedObject(object: NSManagedObject) -> [String:AnyObject]{
        var dictionary:[String:AnyObject] = [:]
        
        let entity = object.entity
        let attributes = entity.attributesByName

        for attribute in attributes {
            let attributeName = attribute.0 
            dictionary[attributeName] = object.valueForKey(attributeName)
        }
        
        return dictionary
    }
}