//
//  Position.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

class Position: Equatable, Identifiable {
    // MARK: - Properties
    let id = UUID()
    let productId: String
    let minimalCountingStep: Decimal
    let price: Decimal
    var amount: Decimal

    // MARK: - Initialization
    init(productId: String, minimalCountingStep: Decimal, price: Decimal) {
        self.productId = productId
        self.minimalCountingStep = minimalCountingStep
        self.amount = minimalCountingStep
        self.price = price
    }

    init(productId: String, minimalCountingStep: Decimal, price: Decimal, amount: Decimal) {
        self.productId = productId
        self.minimalCountingStep = minimalCountingStep
        self.amount = amount
        self.price = price
    }
    
    // MARK: - Computed properties
    var sum: Decimal {
        price * amount
    }

    // MARK: - Methods
    func increment() {
        amount += minimalCountingStep
    }
    
    func decrement() {
        guard amount != 0 else { return }
        if amount > minimalCountingStep {
            amount -= minimalCountingStep
        } else {
            amount = 0
        }
    }
    
    // MARK: - Protocol conformance
    static func == (lhs: Position, rhs: Position) -> Bool {
        lhs.productId == rhs.productId
    }
}
