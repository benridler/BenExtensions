//
//  CaseIterable.swift
//  
//
//  Created by Benjamin Ridler on 26/5/2022.
//

public extension CaseIterable where Self: Equatable, AllCases: BidirectionalCollection {
    /// The previous element of the `CaseIterable` collection
    var preceding: Self? {
        Self.allCases
            .firstIndex(of: self)
            .flatMap(Self.allCases.preceding)
    }
    
    /// The next element of the `CaseIterable` collection
    var succeeding: Self? {
        Self.allCases
            .firstIndex(of: self)
            .flatMap(Self.allCases.succeeding)
    }
    
    /// Finds the first preceding element in the `CaseIterable` collection that satsifies the given predicate
    /// - Parameter allowed: The predicate to determine if the element is allowed
    /// - Returns: The first preceding element that satisfies the predicate
    func findPreceding(where allowed: (Self) -> Bool) -> Self? {
        guard allowed(self) else {
            assertionFailure("findPreceding: Original Case (\(self)) is not a valid case")
            return nil
        }
        var prev: Self? = self.preceding
        while let p = prev, !allowed(p) {
            prev = p.preceding
        }
        return prev
    }
    
    /// Finds the first succeeding element in the `CaseIterable` collection that satsifies the given predicate
    /// - Parameter allowed: The predicate to determine if the element is allowed
    /// - Returns: The first succeeding element that satisfies the predicate
    func findSucceeding(where allowed: (Self) -> Bool) -> Self? {
        guard allowed(self) else {
            assertionFailure("findSucceeding: Original Case (\(self)) is not a valid case")
            return nil
        }
        var next: Self? = self.succeeding
        while let n = next, !allowed(n) {
            next = n.succeeding
        }
        return next
    }
}
