//
//  ProductCardPriceSection.swift
//  1221Test
//
//  Created by Vermut xxx on 17.08.2024.
//

import SwiftUI

struct ProductCardPriceSection: View {
        
    // MARK: - Observation
    
    @StateObject private var vm: ProductCardPriceSectionViewModel
    @EnvironmentObject var cart: Cart
    
    // MARK: - Private properties
    
    @Namespace private var namespace
    
    // MARK: - Initialization
    
    init(_ product: Product) {
        self._vm = StateObject(wrappedValue: ProductCardPriceSectionViewModel(product: product))
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            prices
            button
        }
        .animation(.default, value: vm.amountInCart)
        .padding(4)
    }
    
    // MARK: - Subviews
    
    @ViewBuilder private var finalPrice: some View {
        let finalPriceStrings = vm.finalPrice.splitByPoint()
        HStack(alignment: .top, spacing: 2) {
            Text(finalPriceStrings.integer)
                .font(.system(size: 20))
            if let fraction = finalPriceStrings.fraction {
                Text(fraction)
                    .font(.system(size: 16))
            }
            priceForUnitLabel
        }
        .fontDesign(.rounded)
        .fontWeight(.bold)
    }
    
    @ViewBuilder private var priceForUnitLabel: some View {
        let unit = vm.product.isMeasuredByPieces ? "шт" : "кг"
        VStack(spacing: -2) {
            Text("₽")
                .rotationEffect(.degrees(45))
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 18, height: 2)
            Text(unit)
                .rotationEffect(.degrees(45))
                .offset(x: 4, y: 3)
        }
        .font(.system(size: 12))
        .rotationEffect(.degrees(-45))
        .scaleEffect(0.9)
    }


    @ViewBuilder private var priceBeforeDiscount: some View {
        if let priceBeforeDiscount = vm.priceBeforeDiscount {
            Text(priceBeforeDiscount.formatted(.number))
                .font(.system(size: 12))
                .foregroundStyle(.productCardCountryLabel)
                .strikethrough()
        }
    }
    
    @ViewBuilder private var prices: some View {
        if !vm.isInCart {
            VStack(alignment: .leading, spacing: 0) {
                finalPrice
                priceBeforeDiscount
            }
            .padding(.leading, 4)
            .frame(height: 36)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder private var button: some View {
        VStack {
            if vm.isInCart {
                amountPicker
            } else {
                addToCartButton
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

    @ViewBuilder private var addToCartButton: some View {
        Button {
            withAnimation(.spring) {
                vm.increment()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 18, style: .circular)
                    .matchedGeometryEffect(id: "buttonBackground", in: namespace)
                    .frame(width: 48, height: 36)
                    .foregroundStyle(.sparGreen)
                Image(.cartIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 16, height: 16)
            }
        }
    }
    
    @ViewBuilder private var amountPicker: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .circular)
                .matchedGeometryEffect(id: "buttonBackground", in: namespace)
                .frame(height: 36)
                .foregroundStyle(.sparGreen)
            HStack {
                minusButton
                Spacer()
                currentAmountInCartLabel
                Spacer()
                plusButton
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
        }
    }
    
    @ViewBuilder private var minusButton: some View {
        Button {
            vm.decrement()
        } label: {
            Image(systemName: "minus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .fontWeight(.medium)
        }
    }


    @ViewBuilder private var plusButton: some View {
        Button {
            vm.increment()
        } label: {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .fontWeight(.medium)
        }
    }

    @ViewBuilder private var currentAmountInCartLabel: some View {
        VStack {
            let unit = vm.product.isMeasuredByPieces ? " шт" : " кг"
            Text(vm.amountInCart.formatted(.number) + unit)
                .font(.system(size: 16, weight: .bold, design: .rounded))
            Text(vm.sum.formatted() + " ₽")
                .font(.system(size: 12))
                .opacity(0.8)
        }
    }
}

#Preview {
    ScrollView {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 2)) {
            ProductCardGridCell(Product.sampleProductInGrams)
            ProductCardGridCell(Product.sampleProductInPieces)
        }
        .padding()
    }
}
