import Foundation

public struct Line {
    let gradient: Double
    let yIntercept: Double
    
    init(gradient: Double, yIntercept: Double) {
        self.gradient = gradient
        self.yIntercept = yIntercept
    }
    
    init(_ p1: Point, _ p2: Point) {
        let gradient = Double(p2.y - p1.y) / Double(p2.x - p1.x)
        self.yIntercept = Double(p1.y) - gradient * Double(p1.x)
        self.gradient = gradient
    }
    
    public func contains(_ point: Point) -> Bool {
        Double(point.y) == gradient * Double(point.x) + yIntercept
    }
    
    public func isParallel(to other: Line) -> Bool {
        gradient == other.gradient
    }
    
    public func angleBetween(_ other: Line) -> Double {
        abs(atan((other.gradient - gradient) / (1 + other.gradient * gradient)))
    }
}
