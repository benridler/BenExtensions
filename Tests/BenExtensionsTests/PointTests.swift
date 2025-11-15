//
//  PointTests.swift - BenExtensions
//
//  Created by Benjamin Ridler on 7/3/2023.
//

@testable import BenExtensions
import SwiftUI
import XCTest
import Testing


struct PointTests {
    @Test func comparable() throws {
        #expect(Point(x: 0, y: 0) < Point(x: 5, y: 5))
        #expect(!(Point(x: 0, y: 0) < Point(x: 0, y: 0)))
        
        // 2x2
        #expect(Point(x: 0, y: 0) < Point(x: 1, y: 0))
        #expect(Point(x: 0, y: 0) < Point(x: 0, y: 1))
        
        #expect (Point(x: 1, y: 0) < Point(x: 0, y: 1))
        #expect(!(Point(x: 1, y: 0) > Point(x: 0, y: 1)))
        
        #expect(Point(x: 0, y: 1) < Point(x: 1, y: 1))
        #expect(Point(x: 1, y: 0) < Point(x: 1, y: 1))
        
        // 3x3
        #expect(Point(x: 0, y: 0) < Point(x: 1, y: 0))
        #expect(Point(x: 1, y: 0) < Point(x: 1, y: 1))
        #expect(Point(x: 1, y: 1) < Point(x: 1, y: 2))
        #expect(Point(x: 1, y: 2) < Point(x: 2, y: 2))
        
        #expect(Point(x: 1, y: 0) < Point(x: 0, y: 2))
        #expect(Point(x: 0, y: 1) < Point(x: 2, y: 0))
        #expect(Point(x: 2, y: 1) < Point(x: 1, y: 2))
        
        // Negatives
        #expect(Point(x: -1, y: -1) < Point(x: -1, y: 0))
    }
    
    @Test func addition() throws {
        #expect(Point(x: 0, y: 0) + Point(x: 0, y: 0) == Point(x: 0, y: 0))
        #expect(Point(x: 1, y: 0) + Point(x: 0, y: 1) == Point(x: 1, y: 1))
        #expect(Point(x: 1, y: 1) + Point(x: 1, y: 1) == Point(x: 2, y: 2))
        #expect(Point(x: 1, y: 1) + Point(x: 1, y: 1) == Point(x: 2, y: 2))

        let x1 = Int.random(in: -100...100)
        let y1 = Int.random(in: -100...100)
        let x2 = Int.random(in: -100...100)
        let y2 = Int.random(in: -100...100)
        #expect(Point(x: x1, y: y1) + Point(x: x2, y: y2) == Point(x: x1+x2, y: y1+y2))
    }
    
    @Test func subtraction() throws {
        #expect(Point(x: 0, y: 0) - Point(x: 0, y: 0) == Point(x: 0, y: 0))
        #expect(Point(x: 1, y: 0) - Point(x: 0, y: 1) == Point(x: 1, y: -1))
        #expect(Point(x: 1, y: 1) - Point(x: 1, y: 1) == Point(x: 0, y: 0))
        #expect(Point(x: 2, y: 2) - Point(x: 1, y: 1) == Point(x: 1, y: 1))

        let x1 = Int.random(in: -100...100)
        let y1 = Int.random(in: -100...100)
        let x2 = Int.random(in: -100...100)
        let y2 = Int.random(in: -100...100)
        #expect(Point(x: x1, y: y1) - Point(x: x2, y: y2) == Point(x: x1-x2, y: y1-y2))
    }
    
    @Test func multiplication() throws {
        #expect(Point(x: 0, y: 0) * 1 == Point(x: 0, y: 0))
        #expect(Point(x: 1, y: 1) * 1 == Point(x: 1, y: 1))
        #expect(Point(x: 1, y: 1) * -1 == Point(x: -1, y: -1))
        #expect(Point(x: 2, y: -2) * 2 == Point(x: 4, y: -4))
        #expect(Point(x: 2, y: -2) * 0 == Point(x: 0, y: 0))

        let x = Int.random(in: -100...100)
        let y = Int.random(in: -100...100)
        let f = Int.random(in: -100...100)
        #expect(Point(x: x, y: y) * f == Point(x: x*f, y: y*f))
    }
    
    @Test func directionTo() throws {
        let pZero = Point.zero
        #expect(pZero.directionTo(Point(x: 0, y: 1)) == .s)
        #expect(pZero.directionTo(Point(x: 0, y: -1)) == .n)
        #expect(pZero.directionTo(Point(x: 1, y: 0)) == .e)
        #expect(pZero.directionTo(Point(x: -1, y: 0)) == .w)
        
        #expect(Point(x: 1, y: 1).directionTo(Point(x: 2, y: 2)) == .e)
    }
    
    @Test func distanceTo() throws {
        let pZero = Point.zero
        #expect(pZero.distance(to: .zero) == .zero)
        
        #expect(pZero.distance(to: Point(x: 3, y: 4)) == 5)
        #expect(pZero.distance(to: Point(x: 4, y: 3)) == 5)
        
        #expect(Point(x: -1, y: -1).distance(to: Point(x: 4, y: 11)) == 13)
        #expect(Point(x: -1, y: -1).distance(to: Point(x: 11, y: 4)) == 13)
    }
    
    @Test func stepsTo() throws {
        let pZero = Point.zero
        #expect(pZero.manhattenDistance(to: pZero) == .zero)
        
        #expect(pZero.manhattenDistance(to: Point(x: 0, y: 1)) == 1)
        #expect(pZero.manhattenDistance(to: Point(x: 0, y: -1)) == 1)
        #expect(pZero.manhattenDistance(to: Point(x: 1, y: 0)) == 1)
        #expect(pZero.manhattenDistance(to: Point(x: -1, y: 0)) == 1)
        
        #expect(Point(x: -2, y: -2).manhattenDistance(to: Point(x: 2, y: 2)) == 8)
        #expect(Point(x: 2, y: 2).manhattenDistance(to: Point(x:-2, y:-2)) == 8)
    }
    
    @Test func isStraightLineTo() {
        let pZero = Point.zero
        #expect(pZero.isStaightLine(to: pZero))
        
        #expect(pZero.isStaightLine(to: Point(x: 0, y: 1)))
        #expect(pZero.isStaightLine(to: Point(x: 1, y: 0)))
        
        #expect(!pZero.isStaightLine(to: Point(x: 1, y: 1)))
        #expect(!pZero.isStaightLine(to: Point(x: -1, y: 1)))
        
        #expect(Point(x: 10, y: -10).isStaightLine(to: Point(x: 10, y: 10)))
        #expect(Point(x: 10, y: -10).isStaightLine(to: Point(x: -10, y: -10)))
        
        #expect(!Point(x: 1, y: -2).isStaightLine(to: Point(x: 3, y: -4)))
    }
    
    @Test func angleTo() throws {
        let pZero = Point.zero
        #expect(pZero.angleTo(pZero) == .zero)
        
        #expect(pZero.angleTo(Point(x:  1, y:  0)) == Angle(degrees: 0))
        #expect(pZero.angleTo(Point(x:  0, y:  1)) == Angle(degrees: 90))
        #expect(pZero.angleTo(Point(x: -1, y:  0)) == Angle(degrees: 180))
        #expect(pZero.angleTo(Point(x:  0, y: -1)) == Angle(degrees: -90))
        
        #expect(pZero.angleTo(Point(x:  1, y:  1)) == Angle(degrees: 45))
        #expect(pZero.angleTo(Point(x: -1, y:  1)) == Angle(degrees: 135))
        #expect(pZero.angleTo(Point(x: -1, y: -1)) == Angle(degrees: -135))
        #expect(pZero.angleTo(Point(x:  1, y: -1)) == Angle(degrees: -45))
    }
    
    @Test func angleBetween() throws {
        let pZero = Point.zero
        #expect(pZero.angleBetween(a: pZero, b: pZero) == .zero)
        
        let angle0Point = Point(x: 1, y: 0)
        let angle90Point = Point(x: 0, y: 1)
        
        #expect(pZero.angleBetween(a: angle0Point, b: angle0Point) == .zero)
        
        #expect(pZero.angleBetween(a: angle0Point, b: angle90Point) == Angle(degrees: 90))
        #expect(pZero.angleBetween(a: angle90Point, b: angle0Point) == Angle(degrees: -90))
        
        #expect(pZero.angleBetween(a: angle0Point, b: Point(x: 0, y: 1)) == Angle(degrees: 90))
        #expect(pZero.angleBetween(a: angle0Point, b: Point(x: 0, y: -1)) == Angle(degrees: -90))
        
        #expect(pZero.angleBetween(a: angle0Point, b: Point(x: -1, y: 1)) == Angle(degrees: 135))
        #expect(pZero.angleBetween(a: angle0Point, b: Point(x: -1, y: -1)) == Angle(degrees: -135))
        
        #expect(pZero.angleBetween(a: Point(x: 0, y: 1), b: Point(x: 0, y: -1)) == Angle(degrees: 180))
        #expect(pZero.angleBetween(a: Point(x: 1, y: 0), b: Point(x: -1, y: 0)) == Angle(degrees: 180))
                
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
        #expect(
             pZero.angleBetween(a: Point(x: x1, y: y1), b: Point(x: x2, y: y2)).radians ==
            -pZero.angleBetween(a: Point(x: x2, y: y2), b: Point(x: x1, y: y1)).radians
        )
    }
}
