//
//  UserHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/2/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import CoreData

class UserHelper {
    var user: User!
    var tempUser: User!
    
    class func getInstance() -> UserHelper {
        struct Singleton {
            static var instance = UserHelper()
        }
        return Singleton.instance
    }
    
    func getCurrentUser() -> User? {
        if user == nil {
            let users = CoreDataHelper.getInstance().fetchData("User") as! [User]
            return users.count > 0 ? users[0] : nil
        } else {
            return user
        }
    }
    
    func getTempUser() -> User {
        if tempUser == nil {
            tempUser = User(tokenValue: "", context: CoreDataHelper.getInstance().temporaryContext)
        }
        return tempUser
    }
}

