//
//  Collection.swift
//  
//
//  Created by Benjamin Ridler on 26/5/2022.
//

import Foundation

public extension Collection where Self: BidirectionalCollection {
    private func element(adjacent index: Index, offset: Int) -> Element? {
        Optional(self.index(index, offsetBy: offset))
            .filter(indices.contains)
            .map { self[$0] }
    }
    
    func preceding(_ index: Index) -> Element? {
        element(adjacent: index, offset: -1)
    }
    
    func succeeding(_ index: Index) -> Element? {
        element(adjacent: index, offset: 1)
    }
    
    subscript(safely index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

public extension Array where Element: RandomAccessCollection, Element.Index == Int {
    func transposed() -> [[Element.Element]] {
        guard let first else { return [] }
        return (0..<first.count).map { column in
            self.map { $0[column] }
        }
    }
}

public extension Sequence where Element: Comparable {
    /// Computes the minimum and maximum elements of the sequence.
    func minMax() -> (min: Element, max: Element)? {
        guard let first = self.first(where: { _ in true }) else { return nil }
        
        return reduce((first, first)) { result, value in
            (Swift.min(result.0, value), Swift.max(result.1, value))
        }
    }
}
