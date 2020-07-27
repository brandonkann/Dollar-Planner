//
//  AnalyticsViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-25.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit
import Charts 
class AnalyticsViewController: UIViewController, ChartViewDelegate {
    
    var totalPaymentAmount : String?
    var totalIncomeAmount1 : String?
    var totalSavingAmount : String?
    var paymentdataEntry = PieChartDataEntry(value: 0)
    var incomedataEntry = PieChartDataEntry(value: 0)
    

    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()

    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var incomeReminder: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    // MARK -- PieChart
        pieChart.chartDescription?.text = "Compare the portion of your Income vs Expenses"
        
        paymentdataEntry.value = Double(totalPaymentAmount!) ?? 0
        paymentdataEntry.label = "Expenses"
    
        incomedataEntry.value = Double(totalIncomeAmount1!) ?? 0
        incomedataEntry.label = "Income"
        
        numberOfDownloadsDataEntries = [paymentdataEntry, incomedataEntry]
        
        updateChartData()
    
    // MARK -- Savings

    if let income = Int(totalIncomeAmount1!), let payments = Int(totalPaymentAmount!), let savings = Int(totalSavingAmount!) {
            let yearlySavings1 = "\((income - payments) * 12 + savings)"
            let yearlyIncome1 = "\((income - payments) * 12)"
        
        
        yearlySavings.text = "$\(yearlySavings1)"
        yearlyIncome.text = "Yearly Income: $\(yearlyIncome1)"
        
    }
        
        
        let income = Int(totalIncomeAmount1!) ?? 0
        if income > 0 {
            incomeReminder.text = "Keep going, Your making money!"
        }
        else if income <= 0 {
            incomeReminder.text = "Your making too little money!"
        }
}
    
    
    @IBOutlet weak var yearlyIncome: UILabel!
    @IBOutlet weak var yearlySavings: UILabel!
    
    

    

    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        
        let colors = [UIColor(named:"paymentColor"), UIColor(named: "incomeColor")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        
        pieChart.data = chartData
        
    }

}
