//
//  PaymentViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-23.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit

class PaymentViewController: UITableViewController, UITextFieldDelegate {
    
    var paymentTotal = "0"
    var totalIncomeAmount : String?
    
   
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items1.plist")
    
    var payments : [Payments] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
       
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentItemCell", for: indexPath)
           let payment = payments[indexPath.row]
        cell.textLabel?.text = "\(payment.paymentSource) - $\(payment.paymentAmount)"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 25)
           return cell
       }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
          }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            payments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            saveItems()
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
    }
       

    
    
    // MARK: - Button Logic
    
    @IBAction func paymentButtonPressed(_ sender: UIBarButtonItem) {
        
        
           var textField3 = UITextField()
           var textField4 = UITextField()
           
           let alert = UIAlertController(title: "Add an Expense", message:"", preferredStyle: .alert)
           
           let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
        
        
            let payment_append = Payments(paymentSource: textField3.text!, paymentAmount: Int(textField4.text!) ?? 0)
            self.payments.append(payment_append)
            
            
            self.saveItems()
               
                    
           }

               
           alert.addTextField { (paymentSource) in
               paymentSource.placeholder = "What Expense"
               textField3 = paymentSource
           }
           
        alert.addTextField { (paymentAmount) in
               paymentAmount.text = ""
               paymentAmount.placeholder = "Expense Amount(No cents/Decimal)"
               paymentAmount.keyboardType = .numberPad
               textField4 = paymentAmount
           }
        
           alert.addAction(action)
           
           present(alert, animated: true, completion: nil)
        
         self.tableView.reloadData()
       }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
                  do {
                      let data = try encoder.encode(payments)
                      try data.write(to : dataFilePath!)
                  }
                  catch {
                      print("Error encoding item array \(error)")
                  }
                  
                   self.tableView.reloadData() // this is the magic method that reload the data
    }
    
    func loadItems() {
       if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
        do {
        payments = try decoder.decode([Payments].self, from: data)
        }
        catch {
            print("Error Decoding item array, \(error)")
        }
    }
    }
    
    // MARK - Data Pass to data
    @IBAction func totalButtonPressed(_ sender: UIBarButtonItem) {
       // Sums the total payments here 
        var totalPayment: Int = Int()
    
        for payment in payments {
            totalPayment += Int(payment.paymentAmount)
        }
        
        paymentTotal = String(totalPayment)
        
        
        self.performSegue(withIdentifier: "paymentTransfer", sender: self)
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "paymentTransfer" {
            let destinationVC = segue.destination as! DashboardViewController
            destinationVC.totalPaymentAmount = paymentTotal
            destinationVC.totalIncomeAmount1 = totalIncomeAmount
            
        }
    }
    
    

    
    
    
    

}
