//
//  Double.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation

extension Double {
    var formattingDouleValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return formattedValue
    }
}
