//
//  CartViewModel.swift
//  1221Test
//
//  Created by Vermut xxx on 17.08.2024.
//

import Foundation

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var cartItems: [CartItem] = []

    private var products: [Product] = []
    private let productService: ProductServiceType

    init(productService: ProductServiceType = MockProductService()) {
        self.productService = productService
        updateCartItems()
    }

    func updateCartItems() {
        let cart = Cart.shared
        Task {
            do {
                products = try await productService.get()
                cartItems = cart.positions.map { position in
                    let product = products.first { $0.id == position.productId }
                    return CartItem(product: product, position: position)
                }
            } catch {
                print("Error fetching products: \(error)")
            }
        }
    }

    func clearCart() {
        Cart.shared.clear()
        updateCartItems()
    }

    func removeItem(_ item: CartItem) {
        Cart.shared.removePosition(item.position)
        updateCartItems()
    }
}
