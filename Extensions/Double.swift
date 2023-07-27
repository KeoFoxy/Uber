//
//  Double.swift
//  Uber
//
//  Created by Alexander Sorokin on 27.07.2023.
//

import Foundation

extension Double {
    
    private var currencyFormater: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormater.string(for: self) ?? ""
    }
}
