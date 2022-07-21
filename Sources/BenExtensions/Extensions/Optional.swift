//
//  Optional.swift
//  
//
//  Created by Benjamin Ridler on 26/5/2022.
//

import Foundation

public extension Optional {
    func filter(_ isIncluded: (Wrapped) throws -> Bool) rethrows -> Self {
        switch self {
        case let value? where try isIncluded(value):
            return value
        default:
            return nil
        }
    }
}
