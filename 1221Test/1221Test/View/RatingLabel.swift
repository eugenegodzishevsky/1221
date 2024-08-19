//
//  RatingLabel.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct RatingLabel: View {
    
    // MARK: - Properties
    
    let rating: Double
    
    // MARK: - Initialization
    
    init(_ rating: Double) {
        self.rating = rating
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
                .foregroundStyle(.sparYellow)
            Text(rating.formatted(.number))
                .font(.system(size: 12))
        }
        .padding(.vertical, 2)
        .padding(.horizontal, 4)
        .frame(height: 20)
    }
}

#Preview {
    RatingLabel(4.9)
}
