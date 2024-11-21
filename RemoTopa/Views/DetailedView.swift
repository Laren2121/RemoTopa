//
//  DetailedView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-21.
//

import SwiftUI

struct DetailView: View {
    var title: String

    var body: some View {
        
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(title: "Rectangle 1")
    }
}
