//
//  CoreDataHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 10/16/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import CoreData

class CoreDataHelper: NSObject {
    
    lazy var sharedContext: NSManagedObjectContext = {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }()
    
    class func getInstance() -> CoreDataHelper {
        struct Singleton {
            static var instance = CoreDataHelper()
        }
        return Singleton.instance
    }
    
    func fetchData(entityName: String) -> [AnyObject] {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        do {
            return try sharedContext.executeFetchRequest(fetchRequest)
        } catch let error as NSError {
            print("Error while fetching data for \(entityName): \(error.localizedDescription)")
            return [AnyObject]()
        }
    }
}