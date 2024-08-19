//
//  DiscountLabel.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct DiscountLabel: View {
    
    // MARK: - Properties
    
    let discount: Int
    
    // MARK: - Initialization
    
    init(_ discount: Int) {
        self.discount = discount
    }
    
    // MARK: - Body
    
    var body: some View {
        Text(discount.formatted() + "%")
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .foregroundStyle(.sparRed)
            .padding(.horizontal, 5)
    }
}

#Preview {
    DiscountLabel(25)
}
