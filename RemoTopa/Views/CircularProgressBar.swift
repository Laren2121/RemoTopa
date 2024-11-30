//
//  CircularProgressBar.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-30.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: Double
    var lineWidth: CGFloat = 12
    var size: CGFloat = 100
    var foregroundColor: Color = .white.opacity(0.8)
    var backgroundColor: Color = .gray.opacity(0.3)
    var animationDuration: Double = 0.5
    var label: String = ""
    var valueLabel: String = ""

    @State private var animatedProgress: Double = 0
    @State private var showForegroundCircle: Bool = false

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(backgroundColor)

                Circle()
                    .trim(from: 0.0, to: animatedProgress)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    .foregroundColor(.white.opacity(0.6))
                    .rotationEffect(Angle(degrees: -90))
                    .opacity(showForegroundCircle ? 1 : 0)
                    .animation(.easeOut(duration: animationDuration), value: animatedProgress)

                Text(valueLabel)
                    .font(.custom("GeneralSans-Extralight", size: 20))
                    .foregroundColor(.white.opacity(0.6))
            }
            .frame(width: size, height: size)
            .padding(.bottom, 15)

            Text(label)
                .font(.custom("GeneralSans-Extralight", size: 14))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .onAppear {
            // Render background circle first
            // Delay the rendering and animation of the foreground circle
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeOut(duration: animationDuration)) {
                    self.showForegroundCircle = true
                    self.animatedProgress = progress
                }
            }
        }
    }
}
