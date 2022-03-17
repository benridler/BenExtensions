//
//  RoundedTriangle.swift
//  
//
//  Created by Benjamin Ridler on 17/3/2022.
//

import SwiftUI

public struct RoundedTriangle: Shape {
    let radius: CGFloat?
    
    public init(radius: CGFloat? = nil) {
        self.radius = radius
    }
    
    public func path(in rect: CGRect) -> Path {
        let r = radius ?? rect.width/10
        
        let point1 = CGPoint(x: rect.midX, y: rect.minY - r)
        let point2 = CGPoint(x: rect.minX - r/2, y: rect.maxY)
        let point3 = CGPoint(x: rect.maxX + r/2, y: rect.maxY)
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addArc(tangent1End: point3, tangent2End: point1, radius: r)
        path.addArc(tangent1End: point1, tangent2End: point2, radius: r)
        path.addArc(tangent1End: point2, tangent2End: point3, radius: r)
        path.closeSubpath()

        return path
    }
}

struct RoundedTriangle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RoundedTriangle()
                .frame(width: 400, height: 400)
            
            RoundedTriangle(radius: 40)
                .frame(width: 400, height: 400)
            
            RoundedTriangle(radius: 40)
                .frame(width: 400, height: 400)
                .rotationEffect(.degrees(120))
        }
    }
}
