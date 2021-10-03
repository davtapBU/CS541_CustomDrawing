//
//  ShapeBackground.swift
//  CustomDrawing
//
//  Created by David Tapia on 9/29/21.
//
import SwiftUI


struct ShapeBackground: View {
    @State private var dragAmount = CGSize.zero
    
    private var gradientStart = Color(red: 0.0 / 255, green: 210.0 / 255, blue: 120.0 / 255)
    private var gradientEnd = Color(red: 120.0 / 255, green: 125.0 / 255, blue: 210.0 / 255)

    var body: some View {
        //Wrap shape in a geometry reader to be able to adapt to our screen size/aspect ratio
        GeometryReader{ geometry in
            Path { path in
                //Take the minimum of the width and height of our current geometry for both.
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                var height = width
                //Can change the x and y scale of the shape with these two constants
                let xScale: CGFloat = 0.80
                let yScale: CGFloat = 0.90
                
                //Calculating offset from top/bottom and for curves based on geometry dimensions and chosen scale
                let xOffset = (width * (1.0 - xScale)) / 2.0
                let yOffset = (height * (1.0 - yScale)) / 2.0
                
                //Matching the width and height to the chosen scale
                width *= xScale
                height *= yScale
                
                
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
                gradient: Gradient(colors: [gradientStart, gradientEnd]),
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 0.6)
            ))
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in self.dragAmount = .zero }
            )
            .animation(.spring())
            .offset(dragAmount)
        }
    }
    
    mutating func changeGradient(gradStart: Color, gradEnd: Color) {
        gradientStart = gradStart
        gradientEnd = gradEnd
    }
    
}


struct ShapeBackground_Previews: PreviewProvider {
    static var previews: some View {
        ShapeBackground()
    }
}
