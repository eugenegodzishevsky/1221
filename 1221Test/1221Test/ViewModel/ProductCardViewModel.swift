//
//  ProductCardViewModel.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

@MainActor
final class ProductCardViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published private(set) var isFavorited: Bool
    
    // MARK: - Properties
    
    private var product: Product
    
    // MARK: - Initialization
    
    init(_ product: Product) {
        self.product = product
        self.isFavorited = product.isFavorite
    }

    // MARK: - Computed properties
    
    var title: String {
        product.name
    }

    var imageName: String {
        product.imageName
    }
    
    var rating: Double {
        product.rating
    }
    
    var reviewsCount: Int? {
        if let reviews = product.reviews, !reviews.isEmpty {
            return reviews.count
        } else {
            return nil
        }
    }
    
    var promo: Promo? {
        product.promoLabel
    }
    
    var discount: Int? {
        product.saleLabel
    }
    
    var country: Country? {
        product.countryOfOrigin
    }
    
    // MARK: - Methods
    
    func toggleFavorite() {
        isFavorited.toggle()
    }
}
