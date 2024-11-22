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
    var namespace: Namespace.ID
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(color)
            .matchedGeometryEffect(id: title, in: namespace)
            .frame(height: 150)
            //.frame(height: isSelected ? 300 : 150)
            .shadow(color: .black, radius: 4)
            .overlay(
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            )
            .onTapGesture {
                print("Tapped \(title)")
                onTap()
            }
//            .scaleEffect(isSelected ? 1.0 : 1.0)
//            .animation(.spring(), value: isSelected)
    }
}

struct RectangleTile_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        RectangleTile(title: "Sample", color: .blue, namespace: animation, isSelected: false, onTap: {})
            .previewLayout(.sizeThatFits)
    }
}
