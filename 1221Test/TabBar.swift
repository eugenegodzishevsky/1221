//
//  TabBar.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

struct TabBar: View {
    @State var selectedPage = 0

    var body: some View {
        TabView(selection: $selectedPage) {
            MainView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
                .tag(0)
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                }
                .tag(1)
        }
        .accentColor(.green)
    }
}
