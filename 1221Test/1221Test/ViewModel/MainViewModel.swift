//
//  ContentViewModel.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published private(set) var products: [Product] = []
    
    // MARK: - Private properties
    
    private let service: ProductServiceType
    
    // MARK: - Initialization
    
    init() {
        self.service = MockProductService()
        getProducts()
    }

    // MARK: - Private methods
    
    func getProducts() {
        Task {
            self.products = try await service.get()
        }
    }
}
