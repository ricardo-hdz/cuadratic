//
//  NetworkRequestHelper.swift
//  virtual-tourist
//
//  Created by Ricardo Hdz on 10/11/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import UIKit

class NetworkRequestHelper: NSObject {
    var session: NSURLSession!
    var token: String!
    
    override init() {
        super.init()
        session = NSURLSession.sharedSession()
    }
    
    class func getInstance() -> NetworkRequestHelper {
        struct Singleton {
            static var instance = NetworkRequestHelper()
        }
        return Singleton.instance
    }
    
    func serviceRequest(var serviceEndpoint: String, requestMethod: String, headers: NSMutableDictionary, params: [String: AnyObject]?, jsonBody: [String:AnyObject]?, postProcessor: ((data: AnyObject) -> NSData)?, callback: (result: AnyObject?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        if (params != nil) {
            serviceEndpoint = serviceEndpoint + self.escapeParams(params!)
        }
        
        print("Endpoint: \(serviceEndpoint)")

        let url = NSURL(string: serviceEndpoint)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = requestMethod
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (headerField, headerValue) in headers {
            request.addValue(headerValue as! String, forHTTPHeaderField: headerField as! String)
        }
        
        
        if (jsonBody != nil) {
            request.HTTPBody = self.parseJSONBody(jsonBody)
        }
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let error = error {
                callback(result: nil, error: error)
            } else {
                self.parseReponseData(data!, postProcessor: postProcessor, callback: callback)
            }
        }
        
        task.resume()
        return task
    }
    
    func serviceRequestWithToken(serviceEndpoint: String, requestMethod: String, headers: NSMutableDictionary, var params: [String: AnyObject], jsonBody: [String:AnyObject]?, postProcessor: ((data: AnyObject) -> NSData)?, callback: (result: AnyObject?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        params["oauth_token"] = token
        params["v"] = "20151120"
        params["m"] = "foursquare"
        
        return serviceRequest(serviceEndpoint, requestMethod: requestMethod, headers: headers, params: params, jsonBody: jsonBody, postProcessor: postProcessor, callback: callback)
    }
    
    func dataRequest(url: String, callback: (data: NSData?, error: NSError?) -> Void) -> NSURLSessionDataTask {
        let url = NSURL(string: url)
        let task = session.dataTaskWithURL(url!) { data, response, error in
            if let error = error {
                callback(data: nil, error: error)
            } else {
                callback(data: data, error: nil)
            }
        }
        task.resume()
        return task
    }
    
    func shouldSimulate() -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.simulate
    }
    
    func getFoursquareEndpoint() -> String {
        return shouldSimulate() ? Constants.API.FSQ_ENDPOINT + Constants.API.FQS_SIMULATE : Constants.API.FSQ_ENDPOINT
    }
    
    func replaceVenueInEndpoint(endpoint: String, venueId: String) -> String {
        return (shouldSimulate() ? replaceParamsInUrl(endpoint, paramId: "VENUE_ID", paramValue: Constants.API.FQS_SIMULATE_VENUE_ID) : replaceParamsInUrl(endpoint, paramId: "VENUE_ID", paramValue: venueId))!
    }
}