//
//  ExpandedRectangleView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-21.
//

import SwiftUI

struct ExpandedRectangleView: View {
    var title: String
    @Binding var isExpanded: Int?
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.spring()) {
                        isExpanded = nil
                    }
                }
            
            VStack {
                Text(title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(25)
            .shadow(radius: 10)
            .padding()
        }
    }
}

struct ExpandedRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedRectangleView(title: "Rectangle 1", isExpanded: .constant(1))
    }
}
