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

class AgeBreakdownViewController: UIViewController {
    var stats: Stats!
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["12am", "1am", "2am", "3am", "4am", "5am", "6am", "7am", "8am", "9am", "10am", "11am", "12pm", "1pm", "2pm", "3pm", "4pm", "5pm", "6pm", "7pm", "8pm", "9pm", "10pm", "11pm"]
        
        let hours = stats.hourBreakdown
        var hoursToDisplay = [Double]()
        for (var index = 0; index < hours.count; index++) {
            let hour = hours[index]
            hoursToDisplay.append(hour.valueForKey("checkins") as! Double)
        }
        
        setChart(months, values: hoursToDisplay)
        
        let backButton = UIBarButtonItem(title: "Back2", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        self.navigationController!.navigationBar.topItem!.title = "Back"
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
        chartDataSet.colors = [UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1)]
        // Hide values in data bars
        chartDataSet.drawValuesEnabled = false
        
        
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)

        // Hide Background Grid Grid
        barChartView.drawGridBackgroundEnabled = false
        barChartView.drawBarShadowEnabled = false
        
        barChartView.data = chartData
    }
    
}