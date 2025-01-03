//
//  PointTests.swift - BenExtensions
//
//  Created by Benjamin Ridler on 7/3/2023.
//

@testable import BenExtensions
import XCTest
import SwiftUI


final class PointTests: XCTestCase {
    func testComparable() throws {
        XCTAssertTrue(Point(x: 0, y: 0) < Point(x: 5, y: 5))
        XCTAssertFalse(Point(x: 0, y: 0) < Point(x: 0, y: 0))
        
        // 2x2
        XCTAssertTrue(Point(x: 0, y: 0) < Point(x: 1, y: 0))
        XCTAssertTrue(Point(x: 0, y: 0) < Point(x: 0, y: 1))
        
        XCTAssertTrue (Point(x: 1, y: 0) < Point(x: 0, y: 1))
        XCTAssertFalse(Point(x: 1, y: 0) > Point(x: 0, y: 1))
        
        XCTAssertTrue(Point(x: 0, y: 1) < Point(x: 1, y: 1))
        XCTAssertTrue(Point(x: 1, y: 0) < Point(x: 1, y: 1))
        
        
        // 3x3
        XCTAssertTrue(Point(x: 0, y: 0) < Point(x: 1, y: 0))
        XCTAssertTrue(Point(x: 1, y: 0) < Point(x: 1, y: 1))
        XCTAssertTrue(Point(x: 1, y: 1) < Point(x: 1, y: 2))
        XCTAssertTrue(Point(x: 1, y: 2) < Point(x: 2, y: 2))
        
        XCTAssertTrue(Point(x: 1, y: 0) < Point(x: 0, y: 2))
        XCTAssertTrue(Point(x: 0, y: 1) < Point(x: 2, y: 0))
        XCTAssertTrue(Point(x: 2, y: 1) < Point(x: 1, y: 2))
        
        
        // Negatives
        XCTAssertTrue(Point(x: -1, y: -1) < Point(x: -1, y: 0))
        
    }
    
    func testAddition() throws {
        XCTAssertEqual(Point(x: 0, y: 0) + Point(x: 0, y: 0), Point(x: 0, y: 0))
        XCTAssertEqual(Point(x: 1, y: 0) + Point(x: 0, y: 1), Point(x: 1, y: 1))
        XCTAssertEqual(Point(x: 1, y: 1) + Point(x: 1, y: 1), Point(x: 2, y: 2))
        XCTAssertEqual(Point(x: 1, y: 1) + Point(x: 1, y: 1), Point(x: 2, y: 2))

        let x1 = Int.random(in: -100...100)
        let y1 = Int.random(in: -100...100)
        let x2 = Int.random(in: -100...100)
        let y2 = Int.random(in: -100...100)
        XCTAssertEqual(Point(x: x1, y: y1) + Point(x: x2, y: y2), Point(x: x1+x2, y: y1+y2))
    }
    
    func testSubtraction() throws {
        XCTAssertEqual(Point(x: 0, y: 0) - Point(x: 0, y: 0), Point(x: 0, y: 0))
        XCTAssertEqual(Point(x: 1, y: 0) - Point(x: 0, y: 1), Point(x: 1, y: -1))
        XCTAssertEqual(Point(x: 1, y: 1) - Point(x: 1, y: 1), Point(x: 0, y: 0))
        XCTAssertEqual(Point(x: 2, y: 2) - Point(x: 1, y: 1), Point(x: 1, y: 1))

        let x1 = Int.random(in: -100...100)
        let y1 = Int.random(in: -100...100)
        let x2 = Int.random(in: -100...100)
        let y2 = Int.random(in: -100...100)
        XCTAssertEqual(Point(x: x1, y: y1) - Point(x: x2, y: y2), Point(x: x1-x2, y: y1-y2))
    }
    
    func testMultiplication() throws {
        XCTAssertEqual(Point(x: 0, y: 0) * 1, Point(x: 0, y: 0))
        XCTAssertEqual(Point(x: 1, y: 1) * 1, Point(x: 1, y: 1))
        XCTAssertEqual(Point(x: 1, y: 1) * -1 , Point(x: -1, y: -1))
        XCTAssertEqual(Point(x: 2, y: -2) * 2, Point(x: 4, y: -4))
        XCTAssertEqual(Point(x: 2, y: -2) * 0, Point(x: 0, y: 0))

        let x = Int.random(in: -100...100)
        let y = Int.random(in: -100...100)
        let f = Int.random(in: -100...100)
        XCTAssertEqual(Point(x: x, y: y) * f, Point(x: x*f, y: y*f))
    }
    
    func testDirectionTo() throws {
        let pZero = Point.zero
        XCTAssertEqual(pZero.directionTo(Point(x: 0, y: 1)), .up)
        XCTAssertEqual(pZero.directionTo(Point(x: 0, y: -1)), .down)
        XCTAssertEqual(pZero.directionTo(Point(x: 1, y: 0)), .right)
        XCTAssertEqual(pZero.directionTo(Point(x: -1, y: 0)), .left)
        
        XCTAssertEqual(Point(x: 1, y: 1).directionTo(Point(x: 2, y: 2)), .right)
    }
    
    func testDistanceTo() throws {
        let pZero = Point.zero
        XCTAssertEqual(pZero.distance(to: .zero), .zero)
        
        XCTAssertEqual(pZero.distance(to: Point(x: 3, y: 4)), 5)
        XCTAssertEqual(pZero.distance(to: Point(x: 4, y: 3)), 5)
        
        XCTAssertEqual(Point(x: -1, y: -1).distance(to: Point(x: 4, y: 11)), 13)
        XCTAssertEqual(Point(x: -1, y: -1).distance(to: Point(x: 11, y: 4)), 13)
    }
    
    func testStepsTo() throws {
        let pZero = Point.zero
        XCTAssertEqual(pZero.manhattenDistance(to: pZero), .zero)
        
        XCTAssertEqual(pZero.manhattenDistance(to: Point(x: 0, y: 1)), 1)
        XCTAssertEqual(pZero.manhattenDistance(to: Point(x: 0, y: -1)), 1)
        XCTAssertEqual(pZero.manhattenDistance(to: Point(x: 1, y: 0)), 1)
        XCTAssertEqual(pZero.manhattenDistance(to: Point(x: -1, y: 0)), 1)
        
        XCTAssertEqual(Point(x: -2, y: -2).manhattenDistance(to: Point(x: 2, y: 2)), 8)
        XCTAssertEqual(Point(x: 2, y: 2).manhattenDistance(to: Point(x:-2, y:-2)), 8)
    }
    
    func testIsStraightLineTo() {
        let pZero = Point.zero
        XCTAssertTrue(pZero.isStaightLine(to: pZero))
        
        XCTAssertTrue(pZero.isStaightLine(to: Point(x: 0, y: 1)))
        XCTAssertTrue(pZero.isStaightLine(to: Point(x: 1, y: 0)))
        
        XCTAssertFalse(pZero.isStaightLine(to: Point(x: 1, y: 1)))
        XCTAssertFalse(pZero.isStaightLine(to: Point(x: -1, y: 1)))
        
        XCTAssertTrue(Point(x: 10, y: -10).isStaightLine(to: Point(x: 10, y: 10)))
        XCTAssertTrue(Point(x: 10, y: -10).isStaightLine(to: Point(x: -10, y: -10)))
        
        XCTAssertFalse(Point(x: 1, y: -2).isStaightLine(to: Point(x: 3, y: -4)))
    }
    
    func testAngleTo() throws {
        let pZero = Point.zero
        XCTAssertEqual(pZero.angleTo(pZero), .zero)
        
        XCTAssertEqual(pZero.angleTo(Point(x:  1, y:  0)), Angle(degrees: 0))
        XCTAssertEqual(pZero.angleTo(Point(x:  0, y:  1)), Angle(degrees: 90))
        XCTAssertEqual(pZero.angleTo(Point(x: -1, y:  0)), Angle(degrees: 180))
        XCTAssertEqual(pZero.angleTo(Point(x:  0, y: -1)), Angle(degrees: -90))
        
        XCTAssertEqual(pZero.angleTo(Point(x:  1, y:  1)), Angle(degrees: 45))
        XCTAssertEqual(pZero.angleTo(Point(x: -1, y:  1)), Angle(degrees: 135))
        XCTAssertEqual(pZero.angleTo(Point(x: -1, y: -1)), Angle(degrees: -135))
        XCTAssertEqual(pZero.angleTo(Point(x:  1, y: -1)), Angle(degrees: -45))
    }
    
    func testAngleBetween() throws {
        let pZero = Point.zero
        XCTAssertEqual(pZero.angleBetween(a: pZero, b: pZero), .zero)
        
        let angle0Point = Point(x: 1, y: 0)
        let angle90Point = Point(x: 0, y: 1)
        
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: angle0Point), .zero)
        
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: angle90Point), Angle(degrees: 90))
        XCTAssertEqual(pZero.angleBetween(a: angle90Point, b: angle0Point), Angle(degrees: -90))
        
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: Point(x: 0, y: 1)), Angle(degrees: 90))
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: Point(x: 0, y: -1)), Angle(degrees: -90))
        
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: Point(x: -1, y: 1)), Angle(degrees: 135))
        XCTAssertEqual(pZero.angleBetween(a: angle0Point, b: Point(x: -1, y: -1)), Angle(degrees: -135))
        
        XCTAssertEqual(pZero.angleBetween(a: Point(x: 0, y: 1), b: Point(x: 0, y: -1)), Angle(degrees: 180))
        XCTAssertEqual(pZero.angleBetween(a: Point(x: 1, y: 0), b: Point(x: -1, y: 0)), Angle(degrees: 180))
                
        XCTAssertEqual(
            pZero.angleBetween(a: Point(x: 1, y: 2), b: Point(x: 2, y: 3)).radians,
            Angle(degrees: -7.12502).radians,
            accuracy: 0.0001
        )
        
        XCTAssertEqual(
            pZero.angleBetween(a: Point(x: -1, y: -2), b: Point(x: 2, y: 3)).radians,
            Angle(degrees: 172.87498).radians,
            accuracy: 0.0001
        )
        
        XCTAssertEqual(
            pZero.angleBetween(a: Point(x: -5, y: -1), b: Point(x: -5, y: 1)).radians,
            Angle(degrees: -22.61986).radians,
            accuracy: 0.0001
        )
        
        XCTAssertEqual(
            pZero.angleBetween(a: Point(x: -5, y: 1), b: Point(x: -5, y: -1)).radians,
            Angle(degrees: 22.61986).radians,
            accuracy: 0.0001
        )
        
        XCTAssertEqual(
            pZero.angleBetween(a: Point(x: -6, y: 3), b: Point(x: 0, y: 9)).radians,
            Angle(degrees: -63.43495).radians,
            accuracy: 0.0001
        )
        
        let x1 = Int.random(in: -10...10)
        let y1 = Int.random(in: -10...10)
        let x2 = Int.random(in: -10...10)
        let y2 = Int.random(in: -10...10)
        XCTAssertEqual(
             pZero.angleBetween(a: Point(x: x1, y: y1), b: Point(x: x2, y: y2)).radians,
            -pZero.angleBetween(a: Point(x: x2, y: y2), b: Point(x: x1, y: y1)).radians
        )
    }
}
