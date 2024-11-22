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
    var isSelected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(color)
            .frame(height: isSelected ? 300 : 150) // Expand height when selected
            .shadow(radius: 10)
            .overlay(
                Text(title)
                    .font(isSelected ? .largeTitle : .headline) // Adjust font size
                    .foregroundColor(.white)
            )
            .animation(.spring(), value: isSelected)
    }
}

struct RectangleTile_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        RectangleTile(title: "Sample", color: .blue, isSelected: false)
            .previewLayout(.sizeThatFits)
    }
}
