//
//  AppIcon.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-12-01.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        
        ZStack {
            // Background
            Color(.darkGray)
                .edgesIgnoringSafeArea(.all)
            
            // Icon
            RoundedRectangle(cornerRadius: 70)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.orange, Color.red]),
                    startPoint: .top,
                    endPoint: .bottom))
                .frame(width: 220, height: 220)
                .overlay(
                    RoundedRectangle(cornerRadius: 70)
                        .stroke(Color.black, lineWidth: 15)
                )
            
            VStack(spacing: 10) { // Add spacing between the arcs
                ZStack {
                    ArcShape(progress: 0.5)
                        .stroke(Color.black, lineWidth: 15)
                        .frame(width: 170, height: 80) // Wider arc
                        .padding(.top, 10) // Padding from top
                    
                    ArcShape2(progress: 0.25)
                        .stroke(Color.black, lineWidth: 15)
                        .frame(width: 140, height: 40) // Smaller arc
                        .padding(.top, 50)
                    
                }
            }
        }
    }
}

struct ArcShape: Shape {
    var progress: Double
    
    func path(in rect: CGRect) -> Path {
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 180)
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        return path
    }
}

struct ArcShape2: Shape {
    var progress: Double
    
    func path(in rect: CGRect) -> Path {
        let startAngle = Angle(degrees: 0)
        let endAngle = Angle(degrees: 180)
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.maxY),
            radius: rect.width / 3,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        return path
    }
}

#Preview {
    AppIcon()
}
