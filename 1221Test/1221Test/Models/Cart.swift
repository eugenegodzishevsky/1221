//
//  Cart.swift
//  1221Test
//
//  Created by Vermut xxx on 15.08.2024.
//

import Foundation

@MainActor
final class Cart: ObservableObject {
    static let shared = Cart()
    @Published var positions: [Position] = []

    init() {}

    func incrementAmountForPosition(_ position: Position) {
        guard let index = positions.firstIndex(where: { $0 == position }) else {
            addPosition(position)
            return
        }
        positions[index].increment()
        objectWillChange.send()
    }

    func decrementAmountForPosition(_ position: Position) {
        guard let index = positions.firstIndex(where: { $0 == position }) else { return }
        guard positions[index].amount > positions[index].minimalCountingStep else {
            removePosition(position)
            return
        }
        positions[index].decrement()
        objectWillChange.send()
    }

    func addPosition(_ position: Position) {
        guard !positions.contains(position) else { return }
        positions.append(position)
        objectWillChange.send()
    }

    func removePosition(_ position: Position) {
        guard let index = positions.firstIndex(where: { $0 == position }) else { return }
        positions.remove(at: index)
        objectWillChange.send()
    }

    func clear() {
        positions.removeAll()
        objectWillChange.send()
    }
}
