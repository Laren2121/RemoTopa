//
//  ExpandedRectangleView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-21.
//

import SwiftUI

struct ExpandedRectangleView: View {
    var title: String
    @Binding var isExpanded: Bool
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded = false
                    }
                }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .frame(width: 300, height: 300)
                .shadow(radius: 20)
                .overlay(
                    VStack(spacing: 20) {
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        // Placeholder for additional information
                        Text("Detailed information about \(title) goes here.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                )
                .matchedGeometryEffect(id: title, in: namespace)
                .transition(.scale)
        }
    }
}

struct ExpandedRectangleView_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        ExpandedRectangleView(title: "Rectangle 1", isExpanded: .constant(true), namespace: animation)
    }
}
