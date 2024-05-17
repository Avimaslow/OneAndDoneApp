//
//  mapShape.swift
//  OneAndDoneApplication
//
//  Created by Avi Maslow on 2/17/24.
//

import SwiftUI

struct mapShape: Shape {
    func path(in rect: CGRect) ->Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX ,y:rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                          control: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.minY))
        
        
            return path
    }
}

struct mapShape_Previews: PreviewProvider {
    static var previews:  some View {
        mapShape()
            .frame(width: 300,height:235)
            .foregroundColor(.brandprimary)
    }
}
