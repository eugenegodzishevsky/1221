//
//  MakeFavoriteButton.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct FavoriteButton: View {
    
    // MARK: - Bindings
    
    let isFavourite: Bool
    
    // MARK: - Properites
    
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(isFavourite ? .isFavoritedIcon : .isNotFavoritedIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 14, height: 14)
                .padding(8)
                .tint(isFavourite ? .sparGreen : .black)
        }
    }
}

#Preview {
    FavoriteButton(isFavourite: true) {
        
    }
}
