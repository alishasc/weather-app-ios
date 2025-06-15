//
//  GraphView.swift
//  CWKTemplate24
//
//  Created by Alisha Carrington on 27/12/2024.
//

import SwiftUI

struct GraphView: View {
    var graphPlots: [GraphModel]
    
    var body: some View {
        // GeometryReader = path uses size of containing view
        GeometryReader { geometry in
            Path { path in
                // set size of graph
                let width = geometry.size.width
                let height = width
                
                // start point
                path.move(
                    to: CGPoint(
                        x: width * (graphPlots.first?.coord.x ?? 0.0),
                        y: height - (height * (graphPlots.first?.coord.y ?? 0.0))  // invert y-axis
                    )
                )
                
                // subsequent points
                graphPlots.forEach { point in
                    path.addLine(
                        to: CGPoint(
                            x: width * point.coord.x,
                            y: height - (height * point.coord.y)
                        )
                    )
                }
                
                // x-axis
                path.move(to: CGPoint(x: width * 0.0, y: height * 1.0))
                path.addLine(to: CGPoint(x: width * 1.0, y: height * 1.0))
                
                // y-axis
                path.move(to: CGPoint(x: width * 0.0, y: height * 0.0))
                path.addLine(to: CGPoint(x: width * 0.0, y: height * 1.0))
            }
            .stroke(
                Color.white,
                style: StrokeStyle(
                    lineWidth: 2.5,
                    lineCap: .round,
                    lineJoin: .round
                )
            )
            
            // loop graphPlots array - draw circle for each coord
            ForEach(0..<graphPlots.count, id: \.self) { index in
                let point = graphPlots[index]
                // match size of graph area
                let width = geometry.size.width
                let height = width
                let circleColors: [Color] = [.so2, .purple, .voc, .pm]
                
                Circle()
                    .fill(circleColors[index])
                    .frame(width: 12, height: 12)
                    .position(
                        x: width * point.coord.x,
                        y: height - (height * point.coord.y)
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)  // keep graph square
        .padding()
        .background(
            Rectangle()
                .foregroundStyle(.teal.gradient)
                .cornerRadius(10)
                .opacity(0.80)
        )
        .padding()
    }
}

#Preview {
    let graph = [
        GraphModel(coord: CGPoint(x: 0.0, y: 0.2)),
        GraphModel(coord: CGPoint(x: 0.33, y: 0.6)),
        GraphModel(coord: CGPoint(x: 0.67, y: 0.8)),
        GraphModel(coord: CGPoint(x: 1.0, y: 0.4))
    ]
    GraphView(graphPlots: graph)
}
