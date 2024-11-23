//
//  RectangleTile.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-21.
//

import SwiftUI

struct RectangleTile: View {
    var index: Int
    var title: String
    var color: Color
    var isSelected: Bool
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    var body: some View {
            RoundedRectangle(cornerRadius: 25)
                .fill(color)
                .matchedGeometryEffect(id: index, in: namespace)
                .frame(height: 150)
                .overlay(
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                )
                .onTapGesture {
                    onTap()
                }
        }
}

struct RectangleTile_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        RectangleTile(index: 1, title: "Sample", color: .blue, isSelected: false, namespace: animation, onTap: { })
            .previewLayout(.sizeThatFits)
    }
}
