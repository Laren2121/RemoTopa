//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    Gradient(colors: [.yellow, .red])
                )
                .frame(width: 200 , height: 200)
                .shadow(color: .black,
                        radius: 4.0,
                        x: 3,
                        y: 4)
        }
    }
}

#Preview {
    ContentView()
}

