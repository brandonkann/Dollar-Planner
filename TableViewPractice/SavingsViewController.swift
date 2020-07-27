//
//  SavingsViewController.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-23.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import UIKit

class SavingsViewController: UIViewController {

    @IBOutlet weak var savingsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func savingsSlider(_ sender: UISlider) {
        let savings = String(format: "%.0f", sender.value)
            savingsLabel.text = "$\(savings)"
    }
    
  

}
