//
//  StatsFormats.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/5/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
extension Stats {
    func getFormattedHour(var hour: String) -> String {
        hour = "\(hour):00"
        let time24hrFormatter = NSDateFormatter()
        time24hrFormatter.dateFormat = "HH:mm"
        let formattedTime = time24hrFormatter.dateFromString(hour
        )
        
        let time12hrFormatter = NSDateFormatter()
        time12hrFormatter.dateFormat = "h:mm a"
        return time12hrFormatter.stringFromDate(formattedTime!)
    }
}