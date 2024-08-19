//
//  Product.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

struct Product: Identifiable {
    
    // MARK: - General properties

    let id: String
    let name: String
    let imageName: String
    let countryOfOrigin: Country
    var isFavorite: Bool
    let rating: Double
    let reviews: [ProductReview]?
    let promoLabel: Promo?
    let saleLabel: Int?

    // MARK: - Properties for goods measured in pieces
    
    let unitWeightInGrams: Decimal?
    let basePricePerUnit: Decimal?
    let salePricePerUnit: Decimal?
    
    // MARK: - Properties for goods measured in grams
    
    let basePricePerKilo: Decimal
    let salePricePerKilo: Decimal?
    
    // MARK: - Initialization
    
    /// Initializer for goods measured in pieces
    init(
        id: String,
        name: String,
        imageName: String,
        countryOfOrigin: Country,
        isFavorite: Bool,
        rating: Double,
        reviews: [ProductReview]?,
        promoLabel: Promo?,
        saleLabel: Int?,

        unitWeightInGrams: Decimal,
        basePricePerUnit: Decimal,
        salePricePerUnit: Decimal?
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.countryOfOrigin = countryOfOrigin
        self.isFavorite = isFavorite
        self.rating = rating
        self.reviews = reviews
        self.promoLabel = promoLabel
        self.saleLabel = saleLabel
        
        self.unitWeightInGrams = unitWeightInGrams
        self.basePricePerUnit = basePricePerUnit
        self.salePricePerUnit = salePricePerUnit
        
        self.basePricePerKilo = 1000 * basePricePerUnit / unitWeightInGrams
        if let salePricePerUnit {
            self.salePricePerKilo = 1000 * salePricePerUnit / unitWeightInGrams
        } else {
            self.salePricePerKilo = nil
        }
    }
    
    /// Initializer for goods measured in grams
    init(
        id: String,
        name: String,
        imageName: String,
        countryOfOrigin: Country,
        isFavorite: Bool,
        rating: Double,
        reviews: [ProductReview]?,
        promoLabel: Promo?,
        saleLabel: Int?,

        basePricePerKilo: Decimal,
        salePricePerKilo: Decimal?
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.countryOfOrigin = countryOfOrigin
        self.isFavorite = isFavorite
        self.rating = rating
        self.reviews = reviews
        self.promoLabel = promoLabel
        self.saleLabel = saleLabel

        self.basePricePerKilo = basePricePerKilo
        self.salePricePerKilo = salePricePerKilo
        
        self.unitWeightInGrams = nil
        self.basePricePerUnit = nil
        self.salePricePerUnit = nil
    }
    
    // MARK: - Computed properties
    
    var isMeasuredByPieces: Bool {
        self.unitWeightInGrams == nil ? false : true
    }
    
    var minimalCountingStep: Decimal {
        if isMeasuredByPieces {
            return 1
        } else {
            return 0.1
        }
    }
    
    var finalPrice: Decimal {
        if isMeasuredByPieces {
            return salePricePerUnit ?? basePricePerUnit!
        } else {
            return salePricePerKilo ?? basePricePerKilo
        }
    }
    
    var priceBeforeDiscount: Decimal? {
        if isMeasuredByPieces {
            return finalPrice == basePricePerUnit ? nil : basePricePerUnit
        } else {
            return finalPrice == basePricePerKilo ? nil : basePricePerKilo
        }
    }
}

extension Product {
    
    // MARK: - Static properties for preview
    
    static var sampleProductInPieces: Product = .init(
        id: "goods7",
        name: "Дорадо Охлажденная Непотрошеная 300-400г",
        imageName: "goods7",
        countryOfOrigin: .russia,
        isFavorite: false,
        rating: 4.9,
        reviews: Array(repeating: ProductReview(), count: 6),
        promoLabel: .priceHit,
        saleLabel: nil,
        unitWeightInGrams: 100,
        basePricePerUnit: 179.9,
        salePricePerUnit: 129.9)
    
    static var sampleProductInGrams: Product = .init(
        id: "goods8",
        name: "сыр Ламбер 500/0 230г",
        imageName: "goods8",
        countryOfOrigin: .france,
        isFavorite: false,
        rating: 4.2,
        reviews: Array(repeating: ProductReview(), count: 281),
        promoLabel: .priceHit,
        saleLabel: 12,
        basePricePerKilo: 164.9,
        salePricePerKilo: 144.9)
}

struct ProductReview {
    
}
