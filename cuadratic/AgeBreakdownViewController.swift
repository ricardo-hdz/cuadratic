//
//  AgeBreakdownViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 11/29/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Foundation
import Charts
import UIKit

class AgeBreakdownViewController: StatisticsViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
        
        let dataToDisplay = getStatisticsBreakdown("hourBreakdown", statisticKey: "checkins")
        
        setChart(months, values: dataToDisplay, barChartView: barChartView, xValues: months, statisticName: "age")

    }    
}