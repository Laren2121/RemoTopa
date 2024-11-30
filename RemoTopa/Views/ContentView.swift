//
//  ContentView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var animationNamespace
    @State private var selectedCity: City? = nil

    let cities: [City] = [
        City(id: 1, name: "Lisbon, Portugal", imageName: "Portugal"),
        City(id: 2, name: "Chiang Mai, Thailand", imageName: "Thailand"),
        City(id: 3, name: "Bali, Indonesia", imageName: "Indonesia"),
        City(id: 4, name: "Berlin, Germany", imageName: "Germany"),
        City(id: 5, name: "Prague, Czech Republic", imageName: "Czechrepublic"),
        City(id: 6, name: "Medellín, Colombia", imageName: "Colombia"),
        City(id: 7, name: "Barcelona, Spain", imageName: "Spain"),
        City(id: 8, name: "Mexico City, Mexico", imageName: "Mexico"),
        City(id: 9, name: "Budapest, Hungary", imageName: "Hungary"),
        City(id: 10, name: "Buenos Aires, Argentina", imageName: "Argentina")
    ]
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [.orange, .black]), startPoint: .top, endPoint: .bottom)
            }
            .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.flexible())], //, GridItem(.flexible())],
                    spacing: 20
                ) {
                    ForEach(cities) { city in
                        CityTile(city: city,
                                 isSelected: selectedCity?.id == city.id,
                                 nameSpace: animationNamespace,
                                 onTap: {
                                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                                    
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selectedCity = city
                                    }
                            }
                        )
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
            .blur(radius: selectedCity != nil ? 10 : 0)
            .animation(.easeInOut(duration: 0.5), value: selectedCity)
            .allowsHitTesting(selectedCity == nil)
            
            if let selectedCity = selectedCity {
                
                Color.clear
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.selectedCity = nil
                        }
                    }
                
                ExpandedCityView(
                    city: selectedCity,
                    namespace: animationNamespace,
                    onTap: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.selectedCity = nil
                        }
                    }
                )
                .transition(.opacity)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
