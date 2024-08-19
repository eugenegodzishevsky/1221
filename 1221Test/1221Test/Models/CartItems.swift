//
//  CartItems.swift
//  1221Test
//
//  Created by Vermut xxx on 17.08.2024.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product?
    let position: Position
}
