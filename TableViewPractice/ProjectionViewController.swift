//
//  ProjectionViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-24.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit

class ProjectionViewController: UIViewController {
    
    var totalPaymentAmount : String?
    var totalIncomeAmount1 : String?
    var totalSavingAmount : String?
    
    @IBOutlet weak var checkSaving: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let income = Int(totalIncomeAmount1!), let payments = Int(totalPaymentAmount!), let savings = Int(totalSavingAmount!) {
                    let profits = "\(income - payments)"
                    let weeklySavings = "\(savings + income - payments)"
            weeklyProfit.text = "$\(profits)"
            savingsTotal.text = "Your total savings is $\(weeklySavings)"
            }
        incomeTotal.text = "$\(totalIncomeAmount1 ?? "")"
        paymentsTotal.text = "$\(totalPaymentAmount ?? "")"
        
        checkSaving.backgroundColor = .clear
        checkSaving.layer.cornerRadius = 8
        checkSaving.layer.borderWidth = 0.5
        checkSaving.tintColor = UIColor.black
        
        
        
        }
    
    @IBOutlet weak var weeklyProfit: UILabel!
    @IBOutlet weak var savingsTotal: UILabel!
    @IBOutlet weak var incomeTotal: UILabel!
    @IBOutlet weak var paymentsTotal: UILabel!
    

    @IBAction func savingAnalytics(_ sender: UIButton) {
        self.performSegue(withIdentifier: "analyticsTransfer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "analyticsTransfer" {
             let destinationVC = segue.destination as! AnalyticsViewController
             destinationVC.totalPaymentAmount = totalPaymentAmount
             destinationVC.totalIncomeAmount1 = totalIncomeAmount1
             destinationVC.totalSavingAmount  = totalSavingAmount
         }
     }
}
