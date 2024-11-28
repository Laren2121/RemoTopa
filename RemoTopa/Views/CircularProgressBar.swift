//
//  CircularProgressBar.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-28.
//
import SwiftUI

struct CircularProgressBar: View {
    var progress: Double // Expected to be between 0 and 1
    var size: CGFloat
    var lineWidth: CGFloat
    var metricType: MetricType
    var displayValue: String
    
    var gradientColors: [Color] = [Color.blue, Color.purple]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(
                    AngularGradient(gradient: Gradient(colors: gradientColors), center: .center),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .animation(.linear, value: progress)
            
            VStack {
                Text(displayValue)
                    .font(.system(size: size * 0.2, weight: .bold))
                    .foregroundColor(.white)
                Text(metricType == .percentage ? "%" : "$")
                    .font(.system(size: size * 0.08, weight: .regular))
                    .foregroundColor(.white)
            }
        }
        .frame(width: size, height: size)
    }
}


struct CircularProgressBar_Previews: PreviewProvider {
  static var previews: some View {
    CircularProgressBar(progress: 0.75, size: 100, lineWidth: 10, metricType: .percentage, displayValue: "75")
  }
}
