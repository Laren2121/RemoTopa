//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animationNamespace
    @State private var selectedRectangle: Int? = nil
    
    var body: some View {
        ZStack {
            // The grid of rectangles
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(1...10, id: \.self) { index in
                        RectangleTile(
                            index: index,
                            title: "Rectangle \(index)",
                            color: .blue,
                            isSelected: selectedRectangle == index,
                            namespace: animationNamespace,
                            onTap: {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    selectedRectangle = index
                                }
                            }
                        )
                    }
                }
                .padding()
            }
            .blur(radius: selectedRectangle != nil ? 10 : 0)
            .animation(.easeInOut(duration: 0.5), value: selectedRectangle)
            .allowsHitTesting(selectedRectangle == nil)
            
            // Overlay when a rectangle is selected
            if let selectedRectangle = selectedRectangle {
                Color.black.opacity(0.3)
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.selectedRectangle = nil
                        }
                    }
                
                ExpandedRectangleView(
                    index: selectedRectangle,
                    title: "Rectangle \(selectedRectangle)",
                    color: .blue,
                    namespace: animationNamespace,
                    onTap: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.selectedRectangle = nil
                        }
                    }
                )
                .transition(.opacity)
            }
        }
    }
    
    private func generateRows() -> [[Int]] {
        var rows: [[Int]] = []
        let totalItems = 10
        var items = Array(1...totalItems)

        // Move the selected rectangle to the front
        if let selected = selectedRectangle {
            items.removeAll { $0 == selected }
            items.insert(selected, at: 0)
        }

        var index = 0

        while index < items.count {
            if items[index] == selectedRectangle {
                // Selected item: make it a full-width row
                rows.append([items[index]])
                index += 1
            } else {
                // Create a row with up to two non-selected items
                var rowItems: [Int] = []
                while rowItems.count < 2 && index < items.count {
                    if items[index] == selectedRectangle {
                        // Skip the selected rectangle
                        index += 1
                    } else {
                        rowItems.append(items[index])
                        index += 1
                    }
                }
                if !rowItems.isEmpty {
                    rows.append(rowItems)
                }
            }
        }

        return rows
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
