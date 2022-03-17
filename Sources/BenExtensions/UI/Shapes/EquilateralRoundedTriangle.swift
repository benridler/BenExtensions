//
//  EquilateralRoundedTriangle.swift
//  
//
//  Created by Benjamin Ridler on 17/3/2022.
//

import SwiftUI

public struct EquilateralRoundedTriangle: View {
    let sideLength: CGFloat
    let radius: CGFloat
    
    public init(sideLength: CGFloat, radius: CGFloat) {
        self.sideLength = sideLength
        self.radius = radius
    }
    
    public var body: some View {
        let yMax = sqrt(3 * sideLength * sideLength / 4)
        let boxSide = 2 * (sideLength - radius/2) / sqrt(3)
        
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: sideLength, height: boxSide)
            
            RoundedTriangle(radius: radius)
                .frame(width: sideLength, height: yMax)
        }
    }
}

struct EquilateralRoundedTriangle_Previews: PreviewProvider {
    static var previews: some View {
        EquilateralRoundedTriangle(sideLength: 400, radius: 40)
            .overlay(Circle().frame(width: 10, height: 10).foregroundColor(.red))
        
        EquilateralRoundedTriangle(sideLength: 400, radius: 40)
            .rotationEffect(.degrees(120))
            .overlay(Circle().frame(width: 10, height: 10).foregroundColor(.red))
    }
}
