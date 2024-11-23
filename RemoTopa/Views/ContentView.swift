//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedRectangle: Int? = nil
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(generateRows(), id: \.self) { row in
                        if row.count == 1 {
                            let index = row[0]
                            let isSelected = selectedRectangle == index
                            
                            RectangleTile(
                                title: "Rectangle \(index)",
                                color: .blue,
                                isSelected: isSelected,
                                onTap: {
                                    withAnimation(.spring) {
                                        selectedRectangle = nil
                                    }
                                }
                            )
                        } else {
                            HStack(spacing: 20) {
                                ForEach(row, id: \.self) { index in
                                    let isSelected = selectedRectangle == index
                                    
                                    RectangleTile(
                                        title: "Rectangle \(index)",
                                        color: .blue,
                                        isSelected: isSelected,
                                        onTap: {
                                            withAnimation(.spring) {
                                                selectedRectangle = index
                                            }
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.vertical, 20)
            }
            
            if selectedRectangle != nil {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedRectangle = nil
                        }
                    }
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
