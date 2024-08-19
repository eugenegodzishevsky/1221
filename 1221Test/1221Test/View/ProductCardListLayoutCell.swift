//
//  ProductCardListLayoutCell.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct ProductCardListCell: View {
    
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
        HStack(spacing: 8) {
            ZStack {
                image
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        if let promo = vm.promo {
                            PromoLabel(promo)
                        }
                    }
                    Spacer()
                    HStack(alignment: .bottom) {
                        if let discount = vm.discount {
                            DiscountLabel(discount)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .frame(width: 144, height: 144)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        HStack(spacing: 4) {
                            RatingLabel(vm.rating)
                            reviewsCountLabel
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        ProductCardText(vm.title, country: vm.country)
                    }
                    actionList
                }
                Spacer()
                ProductCardPriceSection(product)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.vertical, .leading])
        .padding(.trailing, 8)
        .background(.white)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder private var image: some View {
        Image(vm.imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    @ViewBuilder private var reviewsCountLabel: some View {
        if let reviewsCount = vm.reviewsCount {
            HStack(spacing: 4) {
                Divider()
                Text("\(reviewsCount) отзывов")
                    .font(.system(size: 12))
                    .foregroundStyle(.productCardCountryLabel)
            }
            .frame(height: 16)
        }
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
    ScrollView {
        let products: [Product] = [.sampleProductInGrams, .sampleProductInPieces]
        ForEach(products) {
            ProductCardListCell($0)
            Divider()
        }
    }
}

