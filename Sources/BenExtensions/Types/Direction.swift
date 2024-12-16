//  Direction.swift - BenExtensions
//
//  Created by Benjamin Ridler on 22/12/2023

/// A 2D direction
public enum Direction: String, CaseIterable, Sendable {
    case n, e, s, w
    
    public static let up = Direction.n
    public static let right = Direction.e
    public static let down = Direction.s
    public static let left = Direction.w
    
    /// the cardinal / orthogonal directions
    public static let cardinal: [Direction] = [ .n, .e, .s, .w ]
    public static let orthogonal = Direction.cardinal
    
    @available(*, deprecated, message: "Use `cardinal` instead")
    public static var allCases: [Direction] { cardinal }
    
    /// The offset point when moving in this direction
    ///
    /// This follows the pattern where; Top w == (0,0) & Bottom e == (n,n)
    public var offset: Point {
        switch self {
        case .n: Point(x: 0, y: -1)
        case .e: Point(x: 1, y: 0)
        case .s: Point(x: 0, y: 1)
        case .w: Point(x: -1, y: 0)
        }
    }
    
    /// The opposite direction to this direction
    ///
    /// e.g. Up -> Down, Right -> Left
    public var opposite: Self {
        switch self {
        case .n: .s
        case .e: .w
        case .s: .n
        case .w: .e
        }
    }
    
    public func rotated(_ turn: Turn = .clockwise, by degrees: Int = 90) -> Direction {
        switch (turn, degrees) {
        case (.clockwise, 90):
            return switch self {
            case .n: .e
            case .e: .s
            case .s: .w
            case .w: .n
    //                case .ne: return .se
    //                case .nw: return .ne
    //                case .se: return .sw
    //                case .sw: return .nw
            }
//            case (.clockwise, 45):
//                switch self {
//                case .n: return .ne
//                case .e: return .se
//                case .s: return .sw
//                case .w: return .nw
//                case .ne: return .e
//                case .nw: return .n
//                case .se: return .s
//                case .sw: return .w
//                }
        case (.counterclockwise, 90):
            return switch self {
            case .n: .w
            case .e: .n
            case .s: .e
            case .w: .s
//                case .ne: return .nw
//                case .nw: return .sw
//                case .se: return .ne
//                case .sw: return .se
            }
//            case (.counterclockwise, 45):
//                switch self {
//                case .n: return .nw
//                case .e: return .ne
//                case .s: return .se
//                case .w: return .sw
//                case .ne: return .n
//                case .nw: return .w
//                case .se: return .e
//                case .sw: return .s
//                }
        default:
            fatalError("unsupported turn degrees \(degrees)")
        }
    }
    
    public static func randomCardinal() -> Direction {
        cardinal.randomElement()!
    }
}

// MARK: 2d directions
public enum Turn: CaseIterable, Sendable {
    /// turn clockwise / right
    case clockwise

    /// turn counterclockwise / left
    case counterclockwise

    static let right = Turn.clockwise
    static let left = Turn.counterclockwise
}
