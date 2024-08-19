//
//  _221TestApp.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import SwiftUI

@main
struct _221TestApp: App {
    @StateObject private var cart = Cart()

    var body: some Scene {
        WindowGroup {
            TabBar()
                .environmentObject(cart)
        }
    }
}

