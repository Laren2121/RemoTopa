//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                        .frame(height: 150)
                        .shadow(radius: 10)
                        .padding(.horizontal, 20)
                        .overlay(
                            Text("Rectangle \(index + 1)")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            print("Tap on Rectangle \(index + 1)")
                        }
                }
            }
            .padding(.vertical, 20)
        }
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    ContentView()
}

