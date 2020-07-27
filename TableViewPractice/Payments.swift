//
//  Payments.swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-23.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import Foundation

struct Payments : Codable {
    var paymentSource : String
    var paymentAmount : Int
    

    init (paymentSource : String, paymentAmount: Int) {
        self.paymentSource = paymentSource
        self.paymentAmount = paymentAmount
        
    }
}
