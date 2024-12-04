//  Direction.swift - BenExtensions
//
//  Created by Benjamin Ridler on 22/12/2023

public enum Direction: CaseIterable, Sendable {
    case up
    case right
    case down
    case left
    
    /// The offset point when moving in this direction
    ///
    /// This follows the pattern where; Top Left == (0,0) & Bottom Right == (n,n)
    public var offset: Point {
        switch self {
        case .up:
            return .init(x: 0, y: -1)
        case .right:
            return .init(x: 1, y: 0)
        case .down:
            return .init(x: 0, y: 1)
        case .left:
            return .init(x: -1, y: 0)
        }
    }
    
    public var opposite: Self {
        switch self {
        case .up:
            return .down
        case .right:
            return .left
        case .down:
            return .up
        case .left:
            return .right
        }
    }
    
    public static func random() -> Direction {
        allCases.randomElement()!
    }
}
