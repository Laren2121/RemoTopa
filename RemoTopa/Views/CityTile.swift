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
        ZStack(alignment: .topLeading) {
            Image(city.imageName)
                .resizable()
                .scaledToFill()
                .matchedGeometryEffect(id: city.id, in: nameSpace)
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipped()
                .cornerRadius(10)
                .shadow(radius: 5)
            
            Text(city.name)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.6))
                .cornerRadius(10)
                .padding([.top], 15)
                .padding([.leading, .trailing], 5)
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
            city: City(id: 1, name: "Buenos Aires, Argentina", imageName: "Argentina"),
            isSelected: true,
            nameSpace: namespace,
            onTap: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
