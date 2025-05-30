//
//  Pie.swift
//  Memorize
//
//  Created by Pedro Larry Rodrigues Lopes on 18/05/24.
//

import Foundation
import SwiftUI
import CoreGraphics

struct Pie: Shape {
    var startAngle: Angle = .zero // por conveniencia.
    let endAngle: Angle
    var clockwise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height)/2
        
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle, // por conveniencia.
                clockwise: !clockwise // clockwise do iOS é invertido, por isso !clockwise.
            )
        p.addLine(to: center)
        return p
    }
}

#Preview {
    Pie(endAngle: Angle.degrees(90), clockwise: true)
}
