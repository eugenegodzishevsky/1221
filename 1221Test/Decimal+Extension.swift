//
//  Decimal+Extension.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

extension Decimal {
    
    func splitByPoint() -> (integer: String, fraction: String?) {
        let decimalString = "\(self)"
        let components = decimalString.split(separator: ".")
        let integer = String(components[0])
        var fraction = components.count > 1 ? String(components[1]) : nil
        if fraction?.count == 1 {
            fraction = fraction! + "0"
        }
        return (integer, fraction)
    }
    
    func integerPartAsString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: self as NSDecimalNumber) ?? ""
    }
    
    func fractionalPartAsString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: self as NSDecimalNumber) ?? ""
    }
    
    func digitsAfterPoint(minimumDigits: Int, maximumDigits: Int, decimalSeparator: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = minimumDigits
        numberFormatter.maximumFractionDigits = maximumDigits
        numberFormatter.decimalSeparator = decimalSeparator
        return numberFormatter.string(from: self as NSDecimalNumber) ?? ""
    }
}
