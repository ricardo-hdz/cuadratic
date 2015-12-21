//
//  Reachability.swift
//  OnTheMap
//
//  Created by Ricardo Hdz on 9/17/15.
//  Copyright (c) 2015 Ricardo Hdz. All rights reserved.
//
// Class based on http://stackoverflow.com/questions/25398664/check-for-internet-connection-availability-in-swift

import Foundation
import SystemConfiguration

public class ReachabilityHelper {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        
        return isReachable && !needsConnection
    }
    
}

