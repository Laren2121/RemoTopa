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
            Color(.darkGray)
                .edgesIgnoringSafeArea(.all)
        
            RoundedRectangle(cornerRadius: 70)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.orange, Color.orange, Color.red]),
                    startPoint: .top,
                    endPoint: .bottom))
                .frame(width: 220, height: 220)
                .shadow(color: Color.black, radius: 10, x: 0, y: 10)
                .padding(.top, 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 70)
                        .stroke(Color.black, lineWidth: 15)
                        .frame(width: 220, height: 220)
                        .padding(.top, 60)
                )
            
            VStack(spacing: 10) {
                ZStack {
                    ArcShape(progress: 0.5)
                        .stroke(Color.black,
                                style: StrokeStyle(
                                    lineWidth: 15,
                                    lineCap: .round
                                )
                        )
                        .frame(width: 170, height: 80)
                        .padding(.top, 10)
                    
                    ArcShapeChild(progress: 0.25)
                        .stroke(Color.black,
                                style: StrokeStyle(
                                    lineWidth: 15,
                                    lineCap: .round
                                )
                        )
                        .frame(width: 140, height: 40)
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

struct ArcShapeChild: Shape {
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
