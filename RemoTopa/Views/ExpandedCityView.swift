//
//  ExpandedCityView.swift
//  RemoTopa
//
//  Created by Laren Mark D'Cruz on 2024-11-26.
//

import SwiftUI

struct ExpandedCityView: View {
    var city: City
    var namespace: Namespace.ID
    var onTap: () -> Void
    
    @State private var isFullScreen: Bool = false
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            if isFullScreen {
                Image(city.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: city.id, in: namespace)
                    .ignoresSafeArea()
                    .offset(x: dragOffset.width)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset.width = value.translation.width
                            }
                            .onEnded { value in
                                let dragThreshold: CGFloat = 100
                                
                                if abs(dragOffset.width) > dragThreshold {
                                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                                    impactLight.impactOccurred()
                                    
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isFullScreen = false
                                        dragOffset = .zero
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        dragOffset = .zero
                                    }
                                }
                                
                            }
                    )
                    .onTapGesture {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                        
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isFullScreen = false
                        }
                    }
                    
            } else {
                VStack {
                    Spacer()
                    ZStack {
                        Image(city.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: city.id, in: namespace)
                            .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 2)
                            .clipped()
                            .cornerRadius(25)
                        
                        VStack {
                            Spacer()
                            Text(city.name)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(10)
                                .padding([.bottom], 10)
                        }
                    }
                    .onTapGesture(count: 2) {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                        
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isFullScreen = true
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}



struct ExpandedCityView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ExpandedCityView(
            city: City(id: 1, name: "Argentina", imageName: "Argentina"),
            namespace: namespace,
            onTap: {}
        )
    }
}
