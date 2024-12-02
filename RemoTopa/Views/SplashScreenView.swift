//
//  SplashScreenView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-12-01.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            if isActive {
                ContentView()
                    .transition(.opacity)
            } else {
                AppIcon()
                    .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.isActive = true
                }
            }
        }
    }
}
