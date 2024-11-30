//
//  CircularProgressBar.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-30.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: Double // Value between 0 and 1
    var lineWidth: CGFloat = 12
    var size: CGFloat = 100
    var foregroundColor: Color = .blue
    var backgroundColor: Color = .gray.opacity(0.3)
    var animationDuration: Double = 0.5
    var label: String = ""
    var valueLabel: String = ""

    @State private var animatedProgress: Double = 0

    var body: some View {
        VStack {
            ZStack {
                // Background Circle
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(backgroundColor)

                // Foreground Circle
                Circle()
                    .trim(from: 0.0, to: animatedProgress)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .foregroundColor(foregroundColor)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeOut(duration: animationDuration), value: animatedProgress)

                // Value Label
                Text(valueLabel)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .frame(width: size, height: size)

            // Label
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .onAppear {
            self.animatedProgress = progress
        }
    }
}
