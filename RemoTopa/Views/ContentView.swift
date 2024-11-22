//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @Namespace private var animationNamespace

    // State to track which rectangle is expanded (nil if none)
    @State private var selectedRectangle: Int? = nil
    
    var body: some View {
        ZStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        RectangleTile(
                            title: "Rectangle \(index)",
                            color: .blue,
                            namespace: animationNamespace,
                            isSelected: selectedRectangle == index,
                            onTap: {
                                withAnimation(.spring()) {
                                    selectedRectangle = index
                                }
                            }
                        )
                        //Prevents multiple selectionn
                        .disabled(selectedRectangle != nil && selectedRectangle != index)
                    }
                }
            }
            .padding()
        }

        .blur(radius: selectedRectangle != nil ? 10 : 0)
        .animation(.easeInOut, value: selectedRectangle)
        .disabled(selectedRectangle != nil)
        
        if let selected = selectedRectangle {
            ExpandedRectangle(
                title: "Rectangle \(selected)",
                namespace: animationNamespace,
                isExpanded: $selectedRectangle
            )
            //.transition(.scale)
            .zIndex(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
