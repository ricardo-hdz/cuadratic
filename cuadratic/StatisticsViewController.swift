//
//  StatisticsViewController.swift
//  cuadratic
//
//  Created by Ricardo Hdz on 12/21/15.
//  Copyright © 2015 Ricardo Hdz. All rights reserved.
//
import Charts
import UIKit

class StatisticsViewController: UIViewController {
    var stats: Stats!
    
    func getStatisticsBreakdown(statisticId: String, statisticKey: String) -> [Double]{
        let data = stats.valueForKey(statisticId)!
        var dataToDisplay = [Double]()
        for (var index = 0; index < data.count; index++) {
            let value = data[index]
            dataToDisplay.append(value.valueForKey(statisticKey) as! Double)
        }
        return dataToDisplay
    }
    
    func setChart(dataPoints:[String], values:[Double], barChartView: BarChartView, xValues: [String], statisticName: String) {
        barChartView.descriptionText = ""
        
        barChartView.noDataText = "This venue does not have sufficent data to provide an \(statisticName) breakdown."
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
        
        
        let chartData = BarChartData(xVals: xValues, dataSet: chartDataSet)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        // Hide Background Grid Grid
        barChartView.drawGridBackgroundEnabled = false
        barChartView.drawBarShadowEnabled = false
        
        barChartView.data = chartData
    }


}