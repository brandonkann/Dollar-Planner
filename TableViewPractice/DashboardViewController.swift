//
//  DashboardViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-23.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    var totalPaymentAmount : String?
    var totalIncomeAmount1 : String?
    var incomeSaved = "0"
    
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items2.plist")
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var calculateFin: UIButton!
    @IBOutlet weak var financialsSavings: UITextField!
    @IBOutlet weak var paymentValue: UILabel!
    @IBOutlet weak var incomeValue: UILabel!
    @IBOutlet weak var savingsValue: UILabel!
    
    var savings : [Savings] = [Savings(savingsAmount : 20)]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureTapGesture()
        paymentValue.text = "$\(totalPaymentAmount ?? "")"
        incomeValue.text = "$\(totalIncomeAmount1 ?? "")"
        loadItems()
        confirmButton.backgroundColor = .clear
        confirmButton.layer.cornerRadius = 8
        confirmButton.layer.borderWidth = 0.5
        confirmButton.tintColor = UIColor.black
        
        calculateFin.backgroundColor = .clear
        calculateFin.layer.cornerRadius = 8
        calculateFin.layer.borderWidth = 0.5
        calculateFin.tintColor = UIColor.black
        

    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DashboardViewController.handleTap))
         view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    private func configureTextFields() {
        financialsSavings.delegate = self
    }
    
    @IBAction func confirmFinancials(_ sender: UIButton) {
       // savingsValue.text = financialsSavings.text
       // savingsValue.text = String(incomeSaved)
        let save_append = Savings(savingsAmount: Int(financialsSavings.text!) ?? 0)
        self.savings.append(save_append)
        savingsValue.text = "$\(financialsSavings.text ?? "0")"
        incomeSaved = financialsSavings.text!
        saveItems()
        
    }
    
    
    @IBAction func calculateFinancials(_ sender: UIButton) {
        self.performSegue(withIdentifier: "projectionTransfer", sender: self)
        saveItems()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectionTransfer" {
            let destinationVC = segue.destination as! ProjectionViewController
            destinationVC.totalPaymentAmount = totalPaymentAmount
            destinationVC.totalIncomeAmount1 = totalIncomeAmount1
            destinationVC.totalSavingAmount = incomeSaved
        }
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
                  do {
                      let data = try encoder.encode(savings)
                      try data.write(to : dataFilePath!)
                  }
                  catch {
                      print("Error encoding item into array \(error)")
                  }
                  
    }
    
    func loadItems() {
       if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
        do {
        savings = try decoder.decode([Savings].self, from: data)
        }
        catch {
            print("Error Decoding item array, \(error)")
        }
    }
    }
}

extension DashboardViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
 
extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

 
