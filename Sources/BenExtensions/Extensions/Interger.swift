//  Interger.swift - BenExtensions
//
//  Created by Benjamin Ridler on 9/12/2023

import Foundation

public extension Int {
    /// GCD of two numbers:
    static func gcd(_ a: Self, _ b: Self) -> Self {
        var (a, b) = (a, b)
        while b != .zero {
            (a, b) = (b, a % b)
        }
        return abs(a)
    }

    /// LCM of two numbers:
    static func lcm(_ a: Self, _ b: Self) -> Self {
        return (a / gcd(a, b)) * b
    }
}

public extension [Int] {
    /// GCD of a vector of numbers:
    func gcd() -> Element {
        self.reduce(.zero, Int.gcd)
    }

    /// LCM of a vector of numbers:
    func lcm() -> Element {
        self.reduce(1, Int.lcm)
    }
}


