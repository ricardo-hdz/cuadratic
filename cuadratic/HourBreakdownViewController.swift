//
//  HourBreakdownViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/1/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Charts
import UIKit

class HourBreakdownViewController: StatisticsViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var ageSegments: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageSegments = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
        
        let dataToDisplay = getStatisticsBreakdown("ageBreakdown", statisticKey: "checkins")
        setChart(ageSegments, values: dataToDisplay, barChartView: barChartView, xValues: ageSegments, statisticName: "hour")
    }    
}