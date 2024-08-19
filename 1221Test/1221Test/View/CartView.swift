//
//  CartView.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart
    @StateObject private var vm = CartViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                if vm.cartItems.isEmpty {
                    Text("Ваша корзина пуста")
                        .font(.headline)
                        .padding()
                } else {
                    ForEach(vm.cartItems) { item in
                        if let product = item.product {
                            ZStack {
                                ProductCardListCell(product)
                                    .padding([.leading, .trailing], 16)
                                    .padding(.bottom, 8)
                                    .environmentObject(cart)

                                HStack {
                                    Spacer()
                                    Button(action: {
                                        vm.removeItem(item)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .padding(8)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                    .padding(.trailing, 20)
                                }
                                .padding(.bottom, 8)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Корзина")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Очистить") {
                        vm.clearCart()
                    }
                }
            }
        }
        .onAppear {
            vm.updateCartItems()
        }
    }
}

