//
//  PromoLabel.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct PromoLabel: View {
    
    // MARK: - Properties
    
    let promo: Promo
    
    // MARK: - Initialization
    
    init(_ promo: Promo) {
        self.promo = promo
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(promo.rawValue)
            .font(.system(size: 10))
            .foregroundStyle(.white)
            .padding(.top, 2)
            .padding(.bottom, 4)
            .padding(.leading, 12)
            .padding(.trailing, 6)
            .background(promo.bgColor)
            .clipShape(UnevenRoundedRectangle(bottomTrailingRadius: 6, topTrailingRadius: 6, style: .continuous))
    }
}

#Preview {
    PromoLabel(.priceHit)
}
