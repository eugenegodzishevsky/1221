//
//  ProductCardPriceSection.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

@MainActor
final class ProductCardPriceSectionViewModel: ObservableObject {
    // MARK: - Published properties
    
    @Published private(set) var isInCart: Bool = false
    @Published private(set) var amountInCart: Decimal = 0
    
    // MARK: - Properties
    
    let product: Product
    private var position: Position
    
    // MARK: - Initialization
    
    init(product: Product) {
        self.product = product
        self.position = Position(
            productId: product.id,
            minimalCountingStep: product.minimalCountingStep,
            price: product.finalPrice,
            amount: product.minimalCountingStep)
        
        self.updateCartState()
    }
    
    // MARK: - Computed properties
    
    var sum: Decimal {
        position.sum
    }
    
    var finalPrice: Decimal {
        product.finalPrice
    }
    
    var priceBeforeDiscount: Decimal? {
        product.priceBeforeDiscount
    }
    
    // MARK: - Methods

    func increment() {
        Cart.shared.incrementAmountForPosition(position)
        updateCartState()
    }
    
    func decrement() {
        Cart.shared.decrementAmountForPosition(position)
        updateCartState()
    }
    
    // MARK: - Private methods
    
    private func updateCartState() {
        if let updatedPosition = Cart.shared.positions.first(where: { $0.productId == product.id }) {
            self.isInCart = true
            self.amountInCart = updatedPosition.amount
            self.position = updatedPosition
        } else {
            self.isInCart = false
            self.amountInCart = 0
            self.position = Position(
                productId: product.id,
                minimalCountingStep: product.minimalCountingStep,
                price: product.finalPrice,
                amount: product.minimalCountingStep
            )
        }
    }
}
