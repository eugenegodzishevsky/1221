//
//  Country.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

enum Country: String {
    
    // MARK: - Cases
    
    case france = "Франция"
    case russia = "Россия"

    // MARK: - Computed properties
    
    var flag: String {
        switch self {
        case .france: "🇫🇷"
        case .russia: "🇷🇺"
        }
    }
}
