//  String.swift - BenExtensions
//
//  Created by Benjamin Ridler on 1/12/2023

import Foundation

// Helper functions to avoid using String.Index
// These functions are not efficient but are usefully for initial code design
// See https://stackoverflow.com/a/39676940/ for why the default uses String.Index

public extension String {
    subscript(_ i: Int) -> Character? {
        guard i >= startIndex.utf16Offset(in: self),
              i < distance(from: startIndex, to: endIndex)
        else { return nil }
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(_ range: ClosedRange<Int>) -> String? {
        self[range.lowerBound, range.upperBound]
    }
    
    subscript(_ range: Range<Int>) -> String? {
        self[range.lowerBound, range.upperBound]
    }
    
    subscript(_ start: Int, _ end: Int) -> String? {
        guard start >= startIndex.utf16Offset(in: self), 
                start <= end,
                end < distance(from: startIndex, to: endIndex)
        else { return nil }
        return String(
            self[
                (index(startIndex, offsetBy: start)...index(startIndex, offsetBy: end))
            ]
        )
    }
}
