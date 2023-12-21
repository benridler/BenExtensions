//
//  CaseIterableTests.swift
//  
//
//  Created by Benjamin Ridler on 7/6/2023.
//

import Foundation
import XCTest

enum Position: Int, Equatable, CaseIterable {
    case first = 1
    case second
    case third
    case fourth
    case fifth
}

final class CaseIterableTests: XCTestCase {
    func testPreceding() {
        let position = Position.third
        XCTAssertEqual(position.preceding, .second)
    }
    
    func testSucceeding() {
        let position = Position.third
        XCTAssertEqual(position.succeeding, .fourth)
    }
    
    func testPrecedingWhere() {
        let position = Position.fifth
        let preceding = position.findPreceding(where: { position in
            position.rawValue % 4 == 1
        })
        XCTAssertEqual(preceding, .first)
    }
   
    func testSucceedingWhere() {
       let position = Position.first
       let preceding = position.findSucceeding(where: { position in
           position.rawValue % 3 == 1
       })
       XCTAssertEqual(preceding, .fourth)
   }
}
