//
//  ExpandedRectangle.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-22.
//

import SwiftUI

struct ExpandedRectangle: View {
    var title: String
    var namespace: Namespace.ID
    @Binding var isExpanded: Int?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded = nil
                    }
                }
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.blue)
                .matchedGeometryEffect(id: title, in: namespace)
                .frame(width: 300, height: 300)
                .shadow(radius: 20)
                .overlay(
                    VStack(spacing: 20){
                        Text(title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("Detailed information about \(title) will be displayed here.")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            
                    }
                )
                
        }
    }
}

struct ExpandedRectangle_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        ExpandedRectangle(title: "Rectangle 1", namespace: animation, isExpanded: .constant(1))
    }
}
