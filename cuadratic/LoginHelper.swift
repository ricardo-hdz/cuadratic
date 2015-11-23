//
//  LoginHelper.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/22/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation

class LoginHelper {
    
    class func getFoursquareAccessToken(code: String, callback: (token: String?, error: String?) -> Void) {
        let requestHelper = NetworkRequestHelper.getInstance()
        
        let endpoint = requestHelper.replaceParamsInUrl(NetworkRequestHelper.Constants.LOGIN.TOKEN_ENDPOINT, paramId: "auth_code", paramValue: code)
        let headers: NSMutableDictionary = [:]
        
        NetworkRequestHelper.getInstance().serviceRequest(endpoint!, requestMethod: "GET", headers: headers, params: nil, jsonBody: nil, postProcessor: nil) { result, error in
            if let error = error {
                callback(token: nil, error: error.localizedDescription)
            } else {
                if let token = result?.valueForKey("access_token") as? String{
                    callback(token: token, error: nil)
                } else {
                    callback(token: nil, error: "Unable to get token. Please try again.")
                }
            }
        }
    }

}