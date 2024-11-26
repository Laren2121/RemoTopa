//
//  CityView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-26.
//

import SwiftUI

struct CityTile: View {
    var city: City
    var isSelected: Bool
    var nameSpace: Namespace.ID
    var onTap: () -> Void
    
    var body: some View {
        ZStack {
            Image(city.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: city.id, in: nameSpace)
                .frame(height: 150)
                .clipped()
                .cornerRadius(25)
            
            VStack {
                Spacer()
                Text(city.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.6))
                    .cornerRadius(10)
                    .padding([.bottom], 10)
            }
        }
        .onTapGesture {
            onTap()
        }
    }
}

// Preview Provider
struct CityTile_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        CityTile(
            city: City(id: 1, name: "Argentina", imageName: "Argentina"),
            isSelected: true,
            nameSpace: namespace,
            onTap: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
