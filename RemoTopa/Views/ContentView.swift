//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedRectangle: Int? = nil
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<10, id: \.self) { index in
                        NavigationLink(destination: DetailView(title: "Rectangle \(index)")){
                            RectangleTile(title: "Rectangle \(index)", color: .blue)
                        }
                    }
                }
                .background(Color(UIColor.systemBackground))
            }
        }
        .navigationTitle("Scrollable Rectangles")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
