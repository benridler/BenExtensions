//
//  CGRect.swift
//  
//
//  Created by Benjamin Ridler on 17/6/2023.
//

import SwiftUI

extension CGRect {
    var centre: CGPoint {
        .init(x: midX, y: midY)
    }
}
