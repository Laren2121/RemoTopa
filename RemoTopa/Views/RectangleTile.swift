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
    var onTap: () -> Void
    
    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth/2) - 30
        
        
        RoundedRectangle(cornerRadius: 25)
            .fill(color)
            .frame(
                width: isSelected ? screenWidth - 40 : itemWidth,
                height: isSelected ? screenWidth - 40 : 150
            )
            .shadow(radius: 10)
            .overlay(
                Text(title)
                    .font(isSelected ? .largeTitle : .headline) // Adjust font size
                    .foregroundColor(.white)
            )
            .onTapGesture {
                onTap()
            }
            .animation(.spring(), value: isSelected)
    }
}

struct RectangleTile_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        RectangleTile(title: "Sample", color: .blue, isSelected: false, onTap: { })
            .previewLayout(.sizeThatFits)
    }
}
