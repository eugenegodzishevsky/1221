//
//  Promo.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

enum Promo: String {
    
    // MARK: - Cases
    
    case priceHit = "Удар по ценам"
    case new = "Новинки"
    case priceByCard = "Цена по карте"
    
    // MARK: - Computed properties
    
    var bgColor: Color {
        switch self {
        case .priceHit:
            .priceHitPromoLabelBackground
        case .new:
            .newPromoLabelBackground
        case .priceByCard:
            .priceByCardPromoLabelBackground
        }
    }
}
