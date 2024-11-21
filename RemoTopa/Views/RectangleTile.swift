//
//  RectangleTile.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-21.
//

import SwiftUI

struct RectangleTile: View {
    
    var title: String
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(
                color
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.blue, Color.purple]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing)
                )
            .frame(height: 150)
            .shadow(color: .black, radius: 4)
            .padding(.horizontal, 10)
            .overlay(
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            )
    }
}

#Preview {
    RectangleTile(title: "Sample", color: .blue)
        .previewLayout(.sizeThatFits)
}
