//
//  ShapeBackground.swift
//  CustomDrawing
//
//  Created by David Tapia on 9/29/21.
//
import SwiftUI


struct ShapeBackground: View {
    var body: some View {
        GeometryReader{ geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                let xScale: CGFloat = 0.900
                let yScale: CGFloat = 0.500
                let xOffset = (width * (1.0 - xScale)) / 2.0
                let yOffset = (height * (1.0 - yScale)) / 2.0
                width *= xScale
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + ShapeParameters.adjustment) + yOffset
                    )
                )

                ShapeParameters.segments.forEach { segment in
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y + yOffset
                        )
                    )
                    
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y + yOffset
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y + yOffset
                        )
                    )
                }
            }
            .fill(LinearGradient(
                gradient: Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
        }
    }
    static let gradientStart = Color(red: 0.0 / 255, green: 210.0 / 255, blue: 120.0 / 255)
    static let gradientEnd = Color(red: 120.0 / 255, green: 125.0 / 255, blue: 210.0 / 255)
}


struct ShapeBackground_Previews: PreviewProvider {
    static var previews: some View {
        ShapeBackground()
    }
}
