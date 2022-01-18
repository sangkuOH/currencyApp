//
//  Currency.swift
//  currencycalculator (iOS)
//
//  Created by 오상구 on 2022/01/18.
//

import Foundation

struct Currency: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: Quotes
}

struct Quotes: Codable {
    let USDKRW: Double
    let USDPHP: Double
    let USDJPY: Double
}
