//
//  BaseHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/2/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit
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
    
    class func sendNotification(controller: UIViewController, body: String) {
        let alertController = UIAlertController(title: "Notification", message:
            body, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        controller.presentViewController(alertController, animated: true, completion: nil)
        
        /*
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 1)
        notification.alertBody = body
        notification.alertAction = "Action"
UIApplication.sharedApplication().scheduleLocalNotification(notification)
        print("Notifiction sent")*/
    }
}