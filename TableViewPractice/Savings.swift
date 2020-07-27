//
//  Savings.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-24.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import Foundation



struct Savings : Codable {
    var savingsAmount : Int
    

    init (savingsAmount: Int) {
        self.savingsAmount = savingsAmount
        
    }
}
