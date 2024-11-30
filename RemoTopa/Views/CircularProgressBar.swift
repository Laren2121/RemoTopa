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
    var foregroundColor: Color = .white.opacity(0.6)
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
                    .foregroundColor(.white.opacity(0.8))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.easeOut(duration: animationDuration), value: animatedProgress)

                // Value Label
                Text(valueLabel)
                    .font(.custom("GeneralSans-Extralight", size: 20))
                    .foregroundColor(.white.opacity(0.6))
            }
            .frame(width: size, height: size)
            .padding(.bottom, 15)

            // Label
            Text(label)
                .font(.custom("GeneralSans-Extralight", size: 14))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .onAppear {
            self.animatedProgress = progress
        }
    }
}
