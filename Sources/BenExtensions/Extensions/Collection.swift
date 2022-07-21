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
}
