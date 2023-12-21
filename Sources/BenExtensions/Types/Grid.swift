//  Grid.swift - BenExtensions
//
//  Created by Benjamin Ridler on 22/12/2023

import Foundation

public struct Grid<Value: Equatable>: MutableCollection {
    public typealias Element = Value
    public typealias Index = Point
    
    private var underlying: [[Value]]
    
    public let height: Int
    public let width: Int
    
    public init(_ initialValue: [[Value]]) {
        self.underlying = initialValue
        self.height = initialValue.count
        self.width = initialValue.first?.count ?? 0
    }
    
    public init(repeating value: Value, height: Int, width: Int) {
        self.underlying = Array(repeating: Array(repeating: value, count: width), count: height)
        self.height = height
        self.width = width
    }
    
    public subscript(safely position: Index) -> Value? {
        guard contains(position) else { return nil }
        return underlying[position.y][position.x]
    }
    
    public subscript(position: Index) -> Value {
        get {
            underlying[position.y][position.x]
        }
        set {
            underlying[position.y][position.x] = newValue
        }
    }
    
    public subscript(x: Int, y: Int) -> Value {
        get {
            underlying[y][x]
        }
        set {
            underlying[y][x] = newValue
        }
    }
    
    public func index(after i: Index) -> Index {
        if i.x < width {
            return .init(x: i.x + 1, y: i.y)
        } else if i.y < height {
            return .init(x: .zero, y: i.y + 1)
        } else {
            return endIndex
        }
    }
    
    public var startIndex: Index = .zero
    public var endIndex: Index {
        guard height > 0 && width > 0 else { return startIndex }
        // Has to be out of bounds
        return Point(x: width - 1, y: height - 1) + Point(x: 1, y: 0)
    }
}

extension Grid: BidirectionalCollection {
    public func index(before i: Point) -> Point {
        if i.x > .zero {
            return .init(x: i.x - 1, y: i.y)
        } else if i.y > .zero {
            return .init(x: .zero, y: i.y - 1)
        } else {
            return startIndex
        }
    }
}

public extension Grid {
    func contains(_ point: Point) -> Bool {
        point.x >= .zero
            && point.y >= .zero
            && point.x < width
            && point.y < height
    }
    
    /// Only works for Square grids
    func transpose() -> Self {
        var newGrid: Self = .init(underlying)
        underlying.enumerated().forEach { yIndex, row in
            row.enumerated().forEach { xIndex, value in
                newGrid[xIndex, yIndex] = value
            }
        }
        return newGrid
    }
}
