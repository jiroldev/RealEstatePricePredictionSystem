//
//  Double+Extensions.swift
//  MartianApp
//
//  Created by Mohammad Azam on 3/13/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        print(numberFormatter.string(from: NSNumber(value: self))!)
        
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
