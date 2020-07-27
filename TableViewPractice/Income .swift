//
//  Income .swift
//  TableViewPractice
//
//  Created by Brandon Kan  on 2020-05-21.
//  Copyright © 2020 Brandon Kan . All rights reserved.
//

import Foundation


struct Income : Encodable, Decodable {
    var incomeSource : String
    var incomeAmount : Int

init(incomeSource : String, incomeAmount: Int) {
    self.incomeSource = incomeSource
    self.incomeAmount = incomeAmount
    }
}
