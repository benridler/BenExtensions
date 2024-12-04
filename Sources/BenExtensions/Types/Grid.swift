//  Grid.swift - BenExtensions
//
//  Created by Benjamin Ridler on 22/12/2023

import Foundation

public struct Grid<Value: Equatable & Sendable>: MutableCollection, Sendable {
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

// TODO: Fix Slice Implementation
//    public subscript(bounds: ClosedRange<Int>) -> [[Value]] {
//        Array(underlying[bounds])
//    }
//    
//    public subscript(bounds: Range<Point>) -> Grid<Value> {
//        .init(self[bounds.lowerBound.y...bounds.upperBound.y].map {
//            Array($0[bounds.lowerBound.x...bounds.upperBound.x])
//        })
//    }
//
//    public subscript(bounds: Range<Point>) -> Slice<Grid<Value>> {
//        .init(base: self, bounds: bounds)
//        self[bounds.lowerBound.y...bounds.upperBound.y].map {
//            Array($0[bounds.lowerBound.x...bounds.upperBound.x])
//        }
//    }
    
    public func index(after i: Index) -> Index {
        if i.x < width - 1 {
            return .init(x: i.x + 1, y: i.y)
        } else if i.y < height - 1 {
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

extension Grid: Equatable {
    public static func == (lhs: Grid<Value>, rhs: Grid<Value>) -> Bool {
        lhs.underlying == rhs.underlying
    }
}

extension Grid: BidirectionalCollection {
    public func index(before i: Point) -> Point {
        if i.x + 1 > .zero {
            return .init(x: i.x - 1, y: i.y)
        } else if i.y + 1 > .zero {
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

    func transposed() -> Self {
        .init(underlying.transposed())
    }
}
