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
