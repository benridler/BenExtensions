//  Point.swift - BenExtensions
//
//  Created by Benjamin Ridler on 22/12/2023

import Foundation
import SwiftUI

/// A representation of a position on a 2D plane
public struct Point: Equatable, Codable, Hashable, Sendable {
    /// The X coordinate
    public let x: Int
    /// The Y coordinate
    public let y: Int
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

public extension Point {
    static let zero: Point = .init(x: .zero, y: .zero)
}

extension Point: Comparable {
    /// Top Left == (-n,-n)
    /// Bottom Right == (n,n)
    ///
    /// (0,0) < (0,1) < (1,1)
    /// (-1,1) < (0,0) < (1,0) < (1,1)
    /// (0,0) < (0,1) < (1,1) < (2,1) < (2,2)
    ///
    /// - Note: This is a top-left to bottom-right comparison. X-Axis is considered less than Y-Axis, eg. (2,1) < (1,2)
    public static func < (lhs: Point, rhs: Point) -> Bool {
        let lPos = lhs.x + lhs.y
        let rPos = rhs.x + rhs.y
        
        if lPos != rPos {
            return lPos < rPos
        } else if lhs.y != rhs.y {
            return lhs.y < rhs.y
        } else {
            return lhs.x < rhs.x
        }
    }
}

public extension Point {
    static func + (lhs: Point, rhs: Point) -> Point {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Point, rhs: Point) -> Point {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func * (lhs: Point, rhs: Int) -> Point {
        .init(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    /// Calculates the next optimal ``Direction`` to move towards destination
    ///
    /// Prioritises East & West over North & South.
    ///
    /// Returns nil if the destination equals the point
    /// - Parameter destination: The Destination ``Point``
    /// - Returns: The optimal ``Direction`` to reach the destination
    func directionTo(_ destination: Point) -> Direction? {
        guard self != destination else { return nil }
        
        let diff = destination - self
    
        if diff.y == .zero {
            return diff.x > .zero ? .e : .w
        } else if diff.x == .zero {
            return diff.y > .zero ? .s : .n
        } else if abs(diff.x) >= abs(diff.y) {
            return diff.x > 0 ? .e : .w
        } else if abs(diff.y) >= abs(diff.x) {
            return diff.y > 0 ? .s : .n
        }
            
        return nil
    }
    
    /// Calculates the exact distance to the destination ``Point``
    /// - Parameter destination: The Destination ``Point``
    /// - Returns: The exact distance to the destination ``Point``
    func distance(to destination: Point) -> Double {
        let xDiff = x - destination.x
        let yDiff = y - destination.y
        return sqrt(Double(xDiff*xDiff) + Double(yDiff*yDiff))
    }
    
    /// Calculates the Manhatten distance to the destination ``Point``
    ///
    /// The Manhatten distance is also the absolute difference between the two points
    /// - Parameter destination: The Destination ``Point``
    /// - Returns: The amount of step to the destination ``Point``
    func manhattenDistance(to destination: Point) -> Int {
        abs(self.x - destination.x) + abs(self.y - destination.y)
    }
    
    /// Calculates the angle toward the destination point
    /// - Parameter destination: The Destination ``Point``
    /// - Returns: The angle to destination ``Point``
    func angleTo(_ destination: Point) -> Angle {
        guard self != destination else { return Angle() }
        
        guard self.y != destination.y else { return Angle(radians: self.x < destination.x ? 0 : .pi) }
        guard self.x != destination.x else { return Angle(radians: self.y < destination.y ? .pi/2 : -.pi/2) }
        
        let yDelta = destination.y - self.y
        let xDelta = destination.x - self.x
        
        let angle = atan(CGFloat(yDelta) / CGFloat(xDelta))
        
        if destination.x < self.x {
            return Angle(radians: angle + (destination.y > self.y ? .pi : -.pi))
        } else {
            return Angle(radians: angle)
        }
    }
        
    /// Calculates the size of ∠AOB, where O is self
    ///
    /// If OB is anti-clockwise from OA then the ∠AOB will be positive, if OB is clockwise from OA then ∠AOB will be negative.
    /// Similar to angles calculated on the unit-circle
    /// - Parameters:
    ///   - pointA: The point that creates a line that the angle returned is relative from
    ///   - pointB: The point that creates a line that the angle returned is measured to
    /// - Returns: An angle with size between -180>..180 (-pi>..pi)
    func angleBetween(a pointA: Point, b pointB: Point) -> Angle {
        let angleA = self.angleTo(pointA)
        let angleB = self.angleTo(pointB)
        
        var difference = angleB.radians - angleA.radians
        
        if difference > .pi {
            difference -= 2 * .pi
        } else if difference <= -.pi {
            difference += 2 * .pi
        }
        
        return Angle(radians: difference)
    }
    
    func move(_ direction: Direction) -> Point {
        self + direction.offset
    }
    
    func move(_ direction: Direction, distance: Int = 1) -> Point {
        self + (direction.offset * distance)
    }
}

public extension Point {
    /// Determines whether the destination ``Point`` is in a straight line from the current tile
    /// - Parameter destination: The Destination ``Point``
    /// - Returns: Whether the two ``Point`` are in a straight line
    func isStaightLine(to destination: Point) -> Bool {
        self.x == destination.x || self.y == destination.y
    }
    
    func isAdjacent(to point: Point) -> Bool {
        self.manhattenDistance(to: point) == 1
    }
}

extension Point: CustomStringConvertible {
    public var description: String {
        return "P(\(x),\(y))"
    }
}

public extension CGPoint {
    init(point: Point) {
        self = .init(x: point.x, y: point.y)
    }
}

public extension CGSize {
    init(point: Point) {
        self = .init(width: point.x, height: point.y)
    }
}
