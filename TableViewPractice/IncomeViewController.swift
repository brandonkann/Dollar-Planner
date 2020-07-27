//
//  ViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-21.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit

class IncomeViewController: UITableViewController {
    
    var incomeTotal = "0"

    
   
    var incomes : [Income] = []
   let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        incomes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeItemCell", for: indexPath)
        let income = incomes[indexPath.row]
        
    
       
    
        cell.textLabel?.text = "\(income.incomeSource) - $\(income.incomeAmount)"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.init(name: "Helvetica", size: 25)
        return cell
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
          }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            incomes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            saveItems()
        }
    }
       
    
    @IBAction func paymentBarButtonPressed(_ sender: UIBarButtonItem) {
        // Sum the total Income here
    var totalIncomeSources: Int = Int()
   
    for income in incomes {
        totalIncomeSources += Int(income.incomeAmount)
        }
    incomeTotal = String(totalIncomeSources)
        
        
        self.performSegue(withIdentifier: "incomeTransfer", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "incomeTransfer" {
               let destinationVC = segue.destination as! PaymentViewController
               destinationVC.totalIncomeAmount = incomeTotal
               
           }
    }
    

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        
        var textField1 = UITextField()
        var textField2 = UITextField()
        
        let alert = UIAlertController(title: "Add a New Income Sources", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let income_append = Income(incomeSource: textField1.text! , incomeAmount: Int(textField2.text!) ?? 0)
            self.incomes.append(income_append)
            self.saveItems()
        }
            
        alert.addTextField { (incomeSource) in
            incomeSource.placeholder = "Add Your income source"
            textField1 = incomeSource
        }
        
        alert.addTextField { (incomeAmount) in
            incomeAmount.text = ""
            incomeAmount.placeholder = "Income Amount(No Cents/Decimals)"
            textField2 = incomeAmount
            incomeAmount.keyboardType = .numberPad
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    
    }
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
                  do {
                      let data = try encoder.encode(incomes)
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
        incomes = try decoder.decode([Income].self, from: data)
        }
        catch {
            print("Error Decoding item array, \(error)")
        }
    }
    }
    
    
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

