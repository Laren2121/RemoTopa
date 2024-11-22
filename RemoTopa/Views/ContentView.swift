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
    

    @State private var selectedRectangle: Int? = nil
    
    var body: some View {
           ScrollView {
               LazyVGrid(columns: columns, spacing: 20) {
                   ForEach(1...10, id: \.self) { index in
                       tileView(for: index)
                   }
               }
               .padding()
           }
       }

       @ViewBuilder
       private func tileView(for index: Int) -> some View {
           let isSelected = selectedRectangle == index

           RectangleTile(
               title: "Rectangle \(index)",
               color: .blue,
               isSelected: isSelected
           )
           .onTapGesture {
               withAnimation(.spring()) {
                   if selectedRectangle == index {
                       selectedRectangle = nil
                   } else {
                       selectedRectangle = index
                   }
               }
           }
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
