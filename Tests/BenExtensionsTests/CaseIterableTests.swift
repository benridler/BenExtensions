//
//  CaseIterableTests.swift
//  
//
//  Created by Benjamin Ridler on 7/6/2023.
//

import Foundation
import Testing

enum Position: Int, Equatable, CaseIterable {
    case first = 1
    case second
    case third
    case fourth
    case fifth
}

struct CaseIterableTests {
    @Test func preceding() {
        let position = Position.third
        #expect(position.preceding == .second)
    }
    
    @Test func succeeding() {
        let position = Position.third
        #expect(position.succeeding == .fourth)
    }
    
    @Test func precedingWhere() {
        let position = Position.fifth
        let preceding = position.findPreceding(where: { position in
            position.rawValue % 4 == 1
        })
        #expect(preceding == .first)
    }
   
    @Test func succeedingWhere() {
       let position = Position.first
       let preceding = position.findSucceeding(where: { position in
           position.rawValue % 3 == 1
       })
        #expect(preceding == .fourth)
   }
}
