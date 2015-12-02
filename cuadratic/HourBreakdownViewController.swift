//
//  HourBreakdownViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/1/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//

import Charts
import UIKit

class HourBreakdownViewController: UIViewController {
    
    var stats: Stats!

    @IBOutlet weak var barChartView: BarChartView!
    
    var ageSegments: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageSegments = ["13-17", "18-24", "25-34", "35-44", "45-54", "55+"]
        
        let ageSegment = stats.ageBreakdown
        var ageToDisplay = [Double]()
        for (var index = 0; index < ageSegment.count; index++) {
            let age = ageSegment[index]
            ageToDisplay.append(age.valueForKey("checkins") as! Double)
        }
        
        setChart(ageSegments, values: ageToDisplay)
    }
    
    func setChart(dataPoints:[String], values:[Double] ) {
        barChartView.descriptionText = ""
        
        barChartView.noDataText = "This venue does not have sufficent data to provide an age breakdown."
        barChartView.xAxis.labelPosition = .Bottom
        
        let formatter: NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        barChartView.leftAxis.valueFormatter = formatter
        barChartView.rightAxis.enabled = false
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.spaceBetweenLabels = 0
        
        barChartView.leftAxis.labelCount = 7
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        // DATASET
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Number of checkins by hour")
        chartDataSet.colors = [UIColor(red: 113/255, green: 242/255, blue: 175/255, alpha: 1)]
        // Hide values in data bars
        chartDataSet.drawValuesEnabled = false
        
        
        let chartData = BarChartData(xVals: ageSegments, dataSet: chartDataSet)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        // Hide Background Grid Grid
        barChartView.drawGridBackgroundEnabled = false
        barChartView.drawBarShadowEnabled = false
        
        barChartView.data = chartData
    }
    
}