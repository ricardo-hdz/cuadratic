//
//  NetworkRequestConstants.swift
//  virtual-tourist
//
//  Created by Ricardo Hdz on 10/11/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation

extension NetworkRequestHelper {
    struct Constants {
        static let CLIENT_ID = "KZWEEPO4KYCHRKZWQG0RJJRYNO2M4ZQC452KBPEOWUHHOGJL"
        static let CLIENT_SECRET = "23CTIW0MZQSGROBU2Z3XYG3DWKWZSE1LDMGR3V4LWKMBW4AP"
        static let REDIRECT_URI = "cuadratic://foursquare"
        
        static let GOOGLE_PLACES_API_KEY = "AIzaSyAg9m-h5tpewZ8O9nkvgIUoJQp9r_9BaMI"
        
        struct LOGIN {
            static let AUTH_ENDPOINT = "https://foursquare.com/oauth2/authenticate" +
                "?client_id=" + Constants.CLIENT_ID +
                "&response_type=code" +
                "&redirect_uri=" + Constants.REDIRECT_URI
            
            static let TOKEN_ENDPOINT = "https://foursquare.com/oauth2/access_token" +
                "?client_id=" + Constants.CLIENT_ID +
                "&client_secret=" + Constants.CLIENT_SECRET +
                "&grant_type=authorization_code" +
                "&redirect_uri=" + Constants.REDIRECT_URI +
                "&code={auth_code}"
        }
        
        struct API {
            static let FSQ_ENDPOINT = "https://api.foursquare.com/v2/"
            static let FQS_SIMULATE = "simulate/"
            static let FQS_SIMULATE_VENUE_ID = "4e0deab3922e6f94b1410af3"

            struct VENUES {
                static let SEARCH_VENUE = "venues/search"
                static let SEARCH_VENUE_PHOTOS = "venues/{VENUE_ID}/photos"
                static let SEARCH_VENUE_STATS = "venues/{VENUE_ID}/stats"
                static let SEARCH_MANAGED = "venues/managed"
                
                struct PARAMS {
                    static let LOCATION = "ll"
                    static let NEAR = "near"
                    static let VENUE_ID = "VENUE_ID"
                    static let LIMIT = "limit"
                }
            }
            
        }
    }
    
   
}