//
//  ContentView.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct MainView: View {
    
    // MARK: - State properties
    
    @State private var layoutType: LayoutType = .grid
    @State private var refreshID = UUID()
    
    // MARK: - Observation
    
    @StateObject private var vm: MainViewModel
    @EnvironmentObject var cart: Cart
    
    // MARK: - Initialization
    
    init() {
        self._vm = StateObject(wrappedValue: MainViewModel())
    }
    
    // MARK: - Enumerations
    
    enum LayoutType {
        case grid
        case table
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if vm.products.isEmpty {
                    ProgressView()
                        .frame(width: 114, height: 114)
                } else {
                    switch layoutType {
                    case .grid:
                            let columns: [GridItem] = [
                                GridItem(.flexible(), spacing: 5),
                                GridItem(.flexible())
                            ]
                            LazyVGrid (columns: columns) {
                                ForEach(vm.products) { product in
                                ProductCardGridCell(product)
                            }
                        }
                        .padding()
                    case .table:
                        ForEach(vm.products) {
                            ProductCardListCell($0)
                            Divider()
                        }
                    }
                }
            }
            .id(refreshID)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    changeLayoutButton
                }
            }
        }
        .onAppear {
            vm.getProducts()
            vm.objectWillChange.send()
                cart.objectWillChange.send()
            refreshID = UUID()
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder private var changeLayoutButton: some View {
        Button {
            if layoutType == .grid {
                layoutType = .table
            } else {
                layoutType = .grid
            }
        } label: {
            Image(layoutType == .grid ? .gridLayoutIcon : .tableLayoutIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundStyle(.sparGreen)
                .padding(12)
                .background(.layoutIconBackground)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Cart.shared) 
}


