//
//  ProductCardGridLayoutCell.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct ProductCardGridCell: View {
    
    // MARK: - Observation
    
    @StateObject private var vm: ProductCardViewModel
    
    // MARK: - Properties
    
    private let product: Product
    
    // MARK: - Initialization
    
    init(_ product: Product) {
        self.product = product
        self._vm = StateObject(wrappedValue: ProductCardViewModel(product))
    }

    // MARK: - Body
    
    var body: some View {
        VStack {
            ZStack {
                image
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        if let promo = vm.promo {
                            PromoLabel(promo)
                        }
                        Spacer()
                        actionList
                    }
                    Spacer()
                    HStack(alignment: .bottom) {
                        RatingLabel(vm.rating)
                        Spacer()
                        if let discount = vm.discount {
                            DiscountLabel(discount)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            ProductCardText(vm.title, country: vm.country)
            ProductCardPriceSection(product)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .clipShape(UnevenRoundedRectangle(
            topLeadingRadius: 16,
            bottomLeadingRadius: 22,
            bottomTrailingRadius: 22,
            topTrailingRadius: 16,
            style: .circular))
        .shadow(color: .black.opacity(0.2), radius: 8)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder private var image: some View {
        Image(vm.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }

    @ViewBuilder private var actionList: some View {
        VStack(spacing: 0) {
            OrderListButton {
            }
            FavoriteButton(isFavourite: vm.isFavorited) {
                vm.toggleFavorite()
            }
        }
        .background(.white.opacity(0.8))
        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 16))
    }
}

#Preview {
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)) {
        ProductCardGridCell(Product.sampleProductInGrams)
        ProductCardGridCell(Product.sampleProductInPieces)
    }
    .padding()
}
